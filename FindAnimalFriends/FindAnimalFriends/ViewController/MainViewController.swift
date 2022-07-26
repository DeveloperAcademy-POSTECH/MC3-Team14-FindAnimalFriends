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
    
    private var isOnboarding: Bool = false
    private var currentAnimal: String = "tiger"
    
    private var openIndex: Int = -1 { // 현재 오픈되어있는 Animal 컨텐츠 중 마지막 index.
        didSet {
            guard oldValue != openIndex else { return }
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
    
    // Go to Onboarding
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: .hund/3, weight: .black), forImageIn: .normal
        )
        button.tintColor = .appColor(.primaryYellow)
        button.addTarget(self, action: #selector(goToOnboarding), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var readyView: ReadyView?
    
    private var entranceView: EntranceView?
    
    // MARK: Dummy - Real Hard Coding
    
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
        
        //nav bar 영역의 버튼이 터치안되기에 숨겨줌
        navigationController?.isNavigationBarHidden = true
        
        configureDummy()
        
        configureSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //index를 통한 handling 예정.
        if UserDefaults.standard.dictionaryRepresentation().keys.contains("clear") {
            openIndex = UserDefaults.standard.integer(forKey: "clear")
        }
        
        if openIndex == -1 {
            setReady()
        }
        
        let _ = memoButtons.map { button in // button 터치 조절
            button.isUserInteractionEnabled = (button.tag <= openIndex)
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
            self?.openIndex = 0
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
            lottieView.isUserInteractionEnabled = false
            lottieViews.append(lottieView)
            backImageView.addSubview(lottieView)
        }
        
        view.addSubview(infoButton)
        
        NSLayoutConstraint.activate([
            infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: .hund/2),
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.hund/6)
        ])
    }
    
    func setupLotties() {
        for (idx, lottie) in lottieViews.enumerated() {
            if openIndex > 4 {
                lottie.checkView.play()
            } else if idx == openIndex - 1 {
                lottie.checkView.play()
            } else if idx < openIndex - 1 {
                lottie.checkView.currentFrame = lottie.checkView.animation?.endFrame ?? 91
            } else {
                lottie.checkView.currentFrame = 0
            }
        }
    }
    
    func setupLights() {
        let path = UIBezierPath()
        if openIndex < 5 {
            for memo in memos[0...openIndex] {
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
        zoomAction(tag: sender.tag, isSound: true)
    }
    
    func zoomAction(tag: Int, isSound: Bool) {
        if isSound {
            AVPlay.shared.playSound(sound: "switchScreen")
        }
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
            if self.openIndex < 5 {
                self.memoButtons[self.openIndex].isUserInteractionEnabled = (Zoom.status == .zoomOut)
            }
        }

        maskLayerAnimation() // light(조명) 확대, 축소
        
        currentAnimal = memos[tag].memoAnimal.replacingOccurrences(of: "Memo", with: "")
        
        showEntranceView()
    }
    
    func maskLayerAnimation() {
        
        let path = UIBezierPath()
        if openIndex < 5 {
            if Zoom.status == .zoomIn {
                for memo in memos[0...openIndex] {
                    path.append(memo.inMaskLayer)
                }
            } else {
                for memo in memos[0...openIndex] {
                    path.append(memo.outMaskLayer)
                }
            }
        } else {
            path.append(UIBezierPath(rect: CGRect(
                origin: .zero,
                size: CGSize(width: .screenW * 2, height: .screenH * 2))))
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
                entranceView.setupComments()
                self.view.addSubview(entranceView)
                self.view.bringSubviewToFront(self.infoButton)
            }
        } else {
            guard let entranceView = entranceView else { return }
            entranceView.removeFromSuperview()
        }
    }
    
    @objc func pushToQuiz() {
        let vc = QuizPageViewController(transitionStyle: .pageCurl, navigationOrientation: .vertical, animalName: currentAnimal)
        AVPlay.shared.playSound(sound: "startGameSound2")
        navigationController?.pushViewController(vc, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { [weak self] in
            self?.zoomAction(tag: 0, isSound: false)
        }
    }
    
    @objc func goToOnboarding() {
        UIView.transition(with: dummyBlack, duration: 1, options: .transitionCrossDissolve) {
            self.isOnboarding = true
            UserDefaults.standard.set(self.isOnboarding, forKey: "isOnboarding")
            self.view.layer.opacity = 0
        } completion: { _ in
            isSplash2.isSplash2 = false
            if Zoom.status == .zoomIn {
                self.zoomAction(tag: 0, isSound: false)
            }
            self.view.window?.rootViewController = UINavigationController(rootViewController: LaunchScreenController())
            // navigation Controller 추가
        }
    }
}
