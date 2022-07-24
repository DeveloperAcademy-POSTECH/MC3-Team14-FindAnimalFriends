//
//  ViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit


class MainViewController: UIViewController {
    
    // MARK: Properties
    
    // 현재 오픈되어있는 Animal 컨텐츠 중 마지막 index.
    private var currentAnimalIndex: Int = 0
    
    // Mask Circle path(경로)를 총괄하는 layer
    private let maskLayer = CAShapeLayer()
    
    // Animal memo data
    private var memos: [Memo] = [
        Memo(memoRatio: [8, 6], memoAnimal: "tigerMemo"),
        Memo(memoRatio: [1.8, 5.5], memoAnimal: "elephantMemo"),
        Memo(memoRatio: [3, 2.5], memoAnimal: "pandaMemo"),
        Memo(memoRatio: [8, 1.6], memoAnimal: "dolphinMemo"),
        Memo(memoRatio: [1.8, 1.5], memoAnimal: "polarbearMemo")
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
//        button.addTarget(self, action: #selector(zoomOutAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: life cycle Method

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(xButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //index를 통한 handling 예정.
        currentAnimalIndex = UserDefaults.standard.integer(forKey: "clear")
    }
}

// MARK: Private Extension

private extension MainViewController {
    
}
