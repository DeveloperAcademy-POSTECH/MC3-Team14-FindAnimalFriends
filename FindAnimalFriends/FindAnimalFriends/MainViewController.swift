//
//  ViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit


class MainViewController: UIViewController {
    
    // MARK: Properties
    
    private var currentAnimalIndex: Int = 0 // 현재 오픈되어있는 Animal 컨텐츠 중 마지막 index.
    
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
//        button.addTarget(self, action: #selector(zoomOutAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: life cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureSubviews()
        
//        setLights()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //index를 통한 handling 예정.
        currentAnimalIndex = UserDefaults.standard.integer(forKey: "clear")
    }
}

// MARK: Private Extension

private extension MainViewController {
    func configureSubviews() {
        view.addSubview(backImageView)
        
        for (idx, i) in memos.enumerated().reversed() { // .enumeratad.reversed 순서 중요.
            let button = memoButton(i)
            button.tag = idx // tag는 순서대로 잘 달린다. cause reversed()
//            button.addTarget(self, action: #selector(zoomAction(_:)), for: .touchUpInside)
            memoButtons.append(button)
            backImageView.addSubview(button)
        }
        
        view.addSubview(cancelButton)
    }
}
