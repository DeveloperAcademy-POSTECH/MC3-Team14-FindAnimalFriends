//
//  ViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit


class MainViewController: UIViewController {
    
    // MARK: Properties
    
    private var currentIndex: Int = 0 // 현재 오픈되어있는 Animal 컨텐츠 중 마지막 index.
    
    private let memos: [Memo] = [ // Animal memo data
        Memo(memoRatio: [8, 6], memoAnimal: "tigerMemo"),
        Memo(memoRatio: [1.8, 5.5], memoAnimal: "elephantMemo"),
        Memo(memoRatio: [3, 2.5], memoAnimal: "pandaMemo"),
        Memo(memoRatio: [8, 1.6], memoAnimal: "dolphinMemo"),
        Memo(memoRatio: [1.8, 1.5], memoAnimal: "polarbearMemo")
    ]
    
    private var memoButtons: [UIButton] = [] // 전체 크기변화 handling을 위한 버튼 배열.
    
    private let maskLayer = CAShapeLayer() // Mask Circle path(경로)를 총괄하는 layer
    
    // MARK: UIComponents
    
    // Memo 모델을 받아 memo버튼을 생성하는 함수.
    private func memoButton(_ memo: Memo) -> UIButton {
        let button = UIButton(frame: memo.memoFrame)
        button.setImage(UIImage(named: memo.memoAnimal), for: .normal)
        // FIXME: 좀 더 알아보고 추가 리팩토링 때 시도하기.
        // button.autoresizingMask = .flexibleWidth
        return button
    }
    
    private let backImageView: UIImageView = { // 크기가 1배수~2배수로 변화하는 corkboard 배경.
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "mainBackground")
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true //이거 추가해야 여기 subView 추가했을 때 서브버튼 액션이 가능해짐
        return imageView
    }()
    
    private let blackView: UIView = { // 어두운 방 느낌을 내기위한 뷰. mask당하는 뷰.
        let uiView = UIView(frame: UIScreen.main.bounds)
        uiView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return uiView
    }()
    
    private lazy var cancelButton: UIButton = { // 확대 -> 축소로 가는 버튼
        let button = UIButton(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(zoomAction(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: life cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //index를 통한 handling 예정.
        currentIndex = UserDefaults.standard.integer(forKey: "clear")
        
        setupLights()
    }
}

// MARK: Private Extension

private extension MainViewController {
    func configureSubviews() {
        view.addSubview(backImageView)
        
        for (idx, i) in memos.enumerated().reversed() { // .enumeratad.reversed 순서 중요.
            let button = memoButton(i)
            button.tag = idx // tag는 순서대로 잘 달린다. cause reversed()
            button.addTarget(self, action: #selector(zoomAction(_:)), for: .touchUpInside)
            memoButtons.append(button)
            backImageView.addSubview(button)
        }
        
        view.addSubview(cancelButton)
    }
    
    func setupLights() {
        let path = UIBezierPath(rect: view.bounds)
        for memo in memos[0...currentIndex] {
            path.append(memo.outMaskLayer)
        }
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        blackView.layer.mask = maskLayer
        backImageView.insertSubview(blackView, at: memos.count - currentIndex - 1) // 중복x. 기존 위치에서 새로운 위치로 업데이트된다.
    }
    
    @objc func zoomAction(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            
            Zoom.status = (Zoom.status == .zoomIn ? .zoomOut : .zoomIn) // toggle

            self.backImageView.frame = self.memos[sender.tag].backImageFrame //
            self.blackView.frame = self.backImageView.bounds // frame -> bounds로 수정 (fix)

            let _ = self.memoButtons.map { button in
                button.frame = self.memos[button.tag].memoFrame
                button.isUserInteractionEnabled = (Zoom.status == .zoomOut)
            }
        }
        
        maskLayerAnimation() // light(조명) 확대, 축소
    }
    
    func maskLayerAnimation() {
        var path = UIBezierPath()
        if Zoom.status == .zoomIn {
            path = UIBezierPath(rect: self.backImageView.bounds)
            for memo in memos[0...currentIndex] {
                path.append(memo.inMaskLayer)
            }
        } else {
            path = UIBezierPath(rect: view.bounds)
            for memo in memos[0...currentIndex] {
                path.append(memo.outMaskLayer)
            }
        }
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = self.maskLayer.path
        animation.toValue = path.cgPath
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        maskLayer.add(animation, forKey: nil)
        DispatchQueue.main.async {
            self.maskLayer.path = path.cgPath
        }
    }
}
