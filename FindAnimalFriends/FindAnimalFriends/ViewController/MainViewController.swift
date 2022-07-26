//
//  ViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit


class MainViewController: UIViewController {
    
    // MARK: Properties
    
    private var currentAnimal: String = "tiger"
    
    private var currentIndex: Int = -1 { // 현재 오픈되어있는 Animal 컨텐츠 중 마지막 index.
        didSet {
            setupLights()
        }
    }
    
    private let memos = [ // Animal memo data
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
    
    private lazy var blackView: UIView = { // 어두운 방 느낌을 내기위한 뷰. mask당하는 뷰.
        let uiView = UIView(frame: UIScreen.main.bounds)
        uiView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        if currentIndex == -1 {
            uiView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getReady)))
        }
        return uiView
    }()
    
    private var readyView: ReadyView?
    
    private var entranceView: EntranceView?

    // MARK: life cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //index를 통한 handling 예정.
        if UserDefaults.standard.dictionaryRepresentation().keys.contains("clear") {
            currentIndex = UserDefaults.standard.integer(forKey: "clear") >= 5 ? 4 : UserDefaults.standard.integer(forKey: "clear")
        }
        
        if currentIndex == -1 {
            setReady()
        }
    }
}

// MARK: Private Extension

private extension MainViewController {
    func setReady() {
        readyView = ReadyView(frame: UIScreen.main.bounds)
        view.addSubview(blackView)
        blackView.addSubview(readyView!)
    }
    
    @objc func getReady() {
        blackView.removeGestureRecognizer(UITapGestureRecognizer())
        UIView.transition(with: blackView,
                          duration: 0.5, options: .transitionCrossDissolve) { [weak self] in
            self?.readyView!.removeFromSuperview()
        }
        UserDefaults.standard.set(0, forKey: "clear")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.currentIndex = 0
        }
    }
    
    func configureSubviews() {
        view.addSubview(backImageView)
        
        for (idx, i) in memos.enumerated().reversed() { // .enumeratad.reversed 순서 중요.
            let button = memoButton(i)
            button.tag = idx // tag는 순서대로 잘 달린다. cause reversed()
            button.addTarget(self, action: #selector(animate(_:)), for: .touchUpInside)
            memoButtons.append(button)
            backImageView.addSubview(button)
        }
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
    
    @objc func animate(_ sender: UIButton) {
        zoomAction(tag: sender.tag)
    }
    
    func zoomAction(tag: Int) {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            
            Zoom.status = (Zoom.status == .zoomIn ? .zoomOut : .zoomIn) // toggle

            self.backImageView.frame = self.memos[tag].backImageFrame //
            self.blackView.frame = self.backImageView.bounds // frame -> bounds로 수정 (fix)

            let _ = self.memoButtons.map { button in
                button.frame = self.memos[button.tag].memoFrame
                button.isUserInteractionEnabled = (Zoom.status == .zoomOut)
            }
        }
        
        maskLayerAnimation() // light(조명) 확대, 축소
        
        currentAnimal = memos[tag].memoAnimal.replacingOccurrences(of: "Memo", with: "")
        
        showEntranceView()
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
    
    func showEntranceView() {
        if Zoom.status == .zoomIn {
            entranceView = EntranceView(frame: .zero)
            guard let entranceView = entranceView else { return }
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) { [weak self] in
                guard let self = self else { return }
                entranceView.frame = self.view.bounds
                entranceView.cancelButton.addTarget(self, action: #selector(self.animate(_:)), for: .touchUpInside)
                entranceView.pushButton.addTarget(self, action: #selector(self.pushToQuiz), for: .touchUpInside)
                entranceView.animalName = self.currentAnimal
                entranceView.setupCodeName()
                self.view.addSubview(entranceView)
            }
        } else {
            guard let entranceView = entranceView else { return }
            entranceView.removeFromSuperview()
        }
    }
    
    @objc func pushToQuiz() {
        let vc = ClearTestViewController()
        vc.animal = currentAnimal // 추후 로직 수정 예정
        navigationController?.pushViewController(vc, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { [weak self] in
            self?.zoomAction(tag: 0)
        }
    }
}
