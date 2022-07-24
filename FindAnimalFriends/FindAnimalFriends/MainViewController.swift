//
//  ViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit


class MainViewController: UIViewController {
    
    // MARK: Properties
    
    private var currentAnimalIndex: Int = 0
    
    private var maskCircles: [UIBezierPath] = []
    
    // 각 animal memo의 위치 비율.
    // 배경화면 크기가 정비율을 지키며 2배가 될 때, 해당 정비율에 맞게 비율을 잡을 수 있도록 하기 위함.
    private let memosRatio: [[CGFloat]] = [
        [8, 6], //tiger
        [1.8, 5.5], //elephant
        [3, 2.5], //panda
        [8, 1.6], //dolphin
        [1.8, 1.5] //polarbear
    ]
    
    // 각 animal memo의 Asset image 이름. 위의 memosRatio와 index순서 같게 함.
    private let memosAnimal = [
        "tigerMemo",
        "elephantMemo",
        "pandaMemo",
        "dolphinMemo",
        "polarbearMemo"
    ]
    
    // 전체 크기변화 handling을 위한 버튼 배열.
    private var memoButtons: [UIButton] = []
    
    // MARK: UIComponents
    
    // origin(x,y좌표)와 Asset image이름을 받아 memo버튼을 생성하는 함수.
    func memoButton(_ origin: CGPoint, imageName: String) -> UIButton {
        let button = UIButton(frame: CGRect(origin: origin, size: .memoSize))
        button.setImage(UIImage(named: imageName), for: .normal)
        button.isUserInteractionEnabled = false //초기엔 모두 인터렉션mode false
        return button
    }
    
    // 크기가 1배수~2배수로 변화하는 corkboard 배경.
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainBackground")
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true //이거 추가해야 여기 subView 추가했을 때 서브버튼 액션이 가능해짐
        return imageView
    }()
    
    private lazy var xButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(zoomOutAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: life cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addSubviewsWithFrame()
        
        view.addSubview(xButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //index를 통한 handling 예정.
        currentAnimalIndex = UserDefaults.standard.integer(forKey: "clear")
        
        setMemoButtonsStatus()
    }
}

// MARK: Private Extension

private extension MainViewController {
    func addSubviewsWithFrame() {
        backImageView.frame = view.bounds
        view.addSubview(backImageView)
        
        // corkboard배경에 animal memo 버튼들 .addSubview로 추가
        for i in 0...4 {
            let ratio = memosRatio[i]
            let button = memoButton(CGPoint(x: .screenW / ratio[0], y: .screenH / ratio[1]), imageName: memosAnimal[i])
            button.tag = i
            button.addTarget(self, action: #selector(zoomInAction(_:)), for: .touchUpInside)
            backImageView.addSubview(button)
            memoButtons.append(button) // 빈 배열에 버튼들 추가. 줌 축소 확대 시 .map 사용하여 전체 핸들링을 위함
        }
    }
    
    // clearIndex를 확인하고 memo버튼의 상태를 결정하는 함수.
    func setMemoButtonsStatus() {
        let _ = memoButtons.map { button in
            if button.tag < currentAnimalIndex {
                button.isUserInteractionEnabled = false
            } else if button.tag == currentAnimalIndex {
                button.isUserInteractionEnabled = true
            }
        }
    }
    
    @objc func zoomInAction(_ sender: UIButton) {
        let ratio = memosRatio[sender.tag] // 뒷 배경이미지의 origin을 잡기 위해 클릭된 버튼의 ratio를 받음.
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
    
            self.backImageView.frame.size = .backDoubleSize // corkboard 배경늘리기. 너비, 높이 * 2 (면적으로는 4배)
            
            // frame을 한 번에 CGRect로 잡지않고, CGPoint&CGSize로 나누어 잡은 이유
            // -> 커진 back을 기준으로 ratio를 잡아야하기에 먼저 사이즈를 키우고, 커진 사이즈와 ratio를 통해 origin을 잡은 것.
            self.backImageView.frame.origin = CGPoint(
                x: -self.backImageView.frame.width / ratio[0] + .screenW/5,
                y: -self.backImageView.frame.height / ratio[1] + .screenH/3
            )
            // sender를 통해선 클릭된 버튼만 전달되지만, 실제 메인에선 하나의 버튼이 커질 때 나머지들도 함께 커져야한다. 그래서 배열을 만들고 map 고차함수를 이용하여 모두의 frame을 잡아준다.
            let _ = self.memoButtons.map { button in
                let tag = button.tag
                button.frame = CGRect(
                    origin: CGPoint(
                        x: self.backImageView.frame.width / self.memosRatio[tag][0],
                        y: self.backImageView.frame.height / self.memosRatio[tag][1]
                    ),
                    size: .memoDoubleSize
                )
            }
        }
        sender.isUserInteractionEnabled = false // zoom in 후에 터치 잠기도록.
    }
    
    @objc func zoomOutAction() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.backImageView.frame = self.view.bounds // 원래 크기인 view.bounds로 회귀.
            let _ = self.memoButtons.map { button in
                let tag = button.tag
                button.frame = CGRect(
                    origin: CGPoint(
                        x: .screenW / self.memosRatio[tag][0],
                        y: .screenH / self.memosRatio[tag][1]
                        ),
                    size: .memoSize
                    )
                // button의 tag를 판단하여 액션처리
                if button.tag == self.currentAnimalIndex {
                    button.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    // mask circle 배열에 추가하는 함수
    func addMaskCircle(frame: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(origin: frame.origin, size: frame.size))
        maskCircles.append(path)
    }
    
    // maskCircles에 저장된 마스크들을 그려내는 함수 (black 배경과 함께)
    func makeLightMask(origin: CGPoint, size: CGSize) {
        let blackView = UIView(frame: view.bounds)
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: view.bounds)
        
        for (idx, i) in maskCircles.enumerated() {
            if idx == maskCircles.count-1 {
                //animation 할 수 있으면...
                path.append(i)
            } else {
                path.append(i)
            }
        }
        
        path.append(UIBezierPath(ovalIn: CGRect(origin: origin, size: size)))

        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd

        blackView.layer.mask = maskLayer

        view.addSubview(blackView)
    }
    
//    func make(rect: CGRect) {
//        let path = UIBezierPath(rect: view.bounds) //전체크기 할당
//        path.append(UIBezierPath(ovalIn: rect)) //동그라미 path 추가
//
//        maskLayer.path = path.cgPath //만든 path를 maskLayer에 넘기기
//        maskLayer.fillRule = .evenOdd //rule - evenOdd일 때는 겹친부분 반전됨. nonZero는 반전안됨.
//
//        blackView.layer.mask = maskLayer //black뷰의 layer 마스크로 만든 layer 지정
//        view.addSubview(blackView)
//    }
//
//    @objc func animate(_ sender: UIButton) {
//        let path = UIBezierPath(rect: view.bounds)
//        if sender.tag == 0 {
//            path.append(UIBezierPath(ovalIn: CGRect(x: 200, y: 400, width: 400, height: 400)))
//        }
//        let animation = CABasicAnimation(keyPath: "path")
//        animation.fromValue = maskLayer.path
//        animation.toValue = path.cgPath
//        animation.duration = 1
//        animation.timingFunction = CAMediaTimingFunction(name: .linear)
//
//        maskLayer.add(animation, forKey: nil)
//        DispatchQueue.main.async {
//            self.maskLayer.path = path.cgPath
//        }
//    }
}
