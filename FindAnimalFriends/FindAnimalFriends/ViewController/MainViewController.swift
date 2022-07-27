//
//  ViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit
import Lottie


class MainViewController: UIViewController {
    
    // MARK: Properties
    
    private var currentAnimal: String = "tiger"
    
    private var currentIndex: Int = -1 { // 현재 오픈되어있는 Animal 컨텐츠 중 마지막 index.
        didSet {
            setupLights()
            setupLotties()
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
    private var lottieViews: [CheckmarkLottieView] = []
    
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
    
    private var readyView: ReadyView?
    
    private var entranceView: EntranceView?
    
    //MARK: Dummy - Real Hard Coding
    
    private var dummyButtons: [UIButton] = []
    
    private let dummyBack: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "mainBackground")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var dummyBlack: UIView = {
        let uiView = UIView(frame: UIScreen.main.bounds)
        uiView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        return uiView
    }()
    
    private func configureDummy() {
        view.addSubview(dummyBack)
        for (idx, i) in memos.enumerated() {
            let button = memoButton(i)
            button.tag = idx
            dummyButtons.append(button)
            dummyBack.addSubview(button)
        }
        dummyBack.addSubview(dummyBlack)
    }

    // MARK: life cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureDummy()
        
        configureSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //index를 통한 handling 예정.
        if UserDefaults.standard.dictionaryRepresentation().keys.contains("clear") {
            currentIndex = UserDefaults.standard.integer(forKey: "clear")
        }
        
        if currentIndex == -1 {
            setReady()
        }
        
        let _ = memoButtons.map { button in // button 터치 조절
            button.isUserInteractionEnabled = (button.tag == currentIndex)
        } //FIXME: 추후 수정가능성있는 부분.
    }
}

// MARK: Private Extension

private extension MainViewController {
    func setReady() {
        readyView = ReadyView(frame: UIScreen.main.bounds)
        readyView?.onboardingBlackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getReady)))
        view.addSubview(readyView!)
    }
    
    @objc func getReady() {
        UIView.transition(with: readyView!,
                          duration: 0.5, options: .transitionCrossDissolve) { [weak self] in
            self?.readyView?.detectiveView.removeFromSuperview()
            self?.readyView?.textLabel.removeFromSuperview()
        }
        UserDefaults.standard.set(0, forKey: "clear")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.readyView?.removeFromSuperview()
            self?.currentIndex = 0
            self?.memoButtons[0].isUserInteractionEnabled = true //FIXME: 그냥 구현용 하드코딩
        }
    }
    
    func configureSubviews() {
        view.addSubview(backImageView)
        
        for (idx, i) in memos.enumerated() { // .enumeratad.reversed 순서 중요.
            let button = memoButton(i)
            button.tag = idx // tag는 순서대로 잘 달린다. cause reversed()
            button.addTarget(self, action: #selector(animate(_:)), for: .touchUpInside)
            memoButtons.append(button)
            backImageView.addSubview(button)
            
            let lottieView = CheckmarkLottieView(frame: i.lottieFrame)
            lottieView.tag = idx
            lottieViews.append(lottieView)
            backImageView.addSubview(lottieView)
        }
    }
    
    func setupLotties() {
        for (idx, lottie) in lottieViews.enumerated() {
            if currentIndex > 4 {
                lottie.checkView.play()
            } else if idx == currentIndex - 1 {
                lottie.checkView.play()
            } else if idx < currentIndex - 1 {
                lottie.checkView.currentFrame = lottie.checkView.animation?.endFrame ?? 91
            } else {
                lottie.checkView.currentFrame = 0
            }
        }
    }
    
    func setupLights() {
        let path = UIBezierPath()
        if currentIndex < 5 {
            for memo in memos[0...currentIndex] {
                path.append(memo.outMaskLayer)
            }
        } else {
            path.append(UIBezierPath(rect: view.bounds))
        }
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .nonZero
        backImageView.layer.mask = maskLayer
    }
    
    @objc func animate(_ sender: UIButton) {
        zoomAction(tag: sender.tag)
    }
    
    func zoomAction(tag: Int) {
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            Zoom.status = (Zoom.status == .zoomIn ? .zoomOut : .zoomIn)

            self.backImageView.frame = self.memos[tag].backImageFrame
            self.dummyBack.frame = self.memos[tag].backImageFrame
            self.dummyBlack.frame = self.dummyBack.bounds

            let _ = self.memoButtons.map { button in
                button.frame = self.memos[button.tag].memoFrame
            }
            
            let _ = self.dummyButtons.map { button in
                button.frame = self.memos[button.tag].memoFrame
            }
            
            let _ = self.lottieViews.map { lottie in
                lottie.frame = self.memos[lottie.tag].lottieFrame
                lottie.checkView.frame.size = self.memos[lottie.tag].lottieFrame.size
            }
            if self.currentIndex < 5 {
                self.memoButtons[self.currentIndex].isUserInteractionEnabled = (Zoom.status == .zoomOut)
            }
        }

        maskLayerAnimation() // light(조명) 확대, 축소
        
        currentAnimal = memos[tag].memoAnimal.replacingOccurrences(of: "Memo", with: "")
        
        showEntranceView()
    }
    
    func maskLayerAnimation() {
        let index = currentIndex > 4 ? 4 : currentIndex
        let path = UIBezierPath()
        if Zoom.status == .zoomIn {
            for memo in memos[0...index] {
                path.append(memo.inMaskLayer)
            }
        } else {
            for memo in memos[0...index] {
                path.append(memo.outMaskLayer)
            }
        }
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = self.maskLayer.path
        animation.toValue = path.cgPath
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        maskLayer.add(animation, forKey: nil)
        self.maskLayer.path = path.cgPath
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
        let vc = QuizPageViewController(transitionStyle: .pageCurl, navigationOrientation: .vertical, animalName: currentAnimal)
        navigationController?.pushViewController(vc, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { [weak self] in
            self?.zoomAction(tag: 0)
        }
    }
}
