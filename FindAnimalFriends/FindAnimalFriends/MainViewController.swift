//
//  ViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit


class MainViewController: UIViewController {
    
    // MARK: Properties
    
    // 각 animal memo의 위치 비율.
    // 화면 크기가 정비율로 커진다면 해당 정비율에 맞게 비율을 잡을 수 있도록 하기 위함.
    private let memosRatio: [[CGFloat]] = [
        [8, 6], //tiger
        [1.8, 5.5], //elephant
        [3, 2.5], //panda
        [8, 1.6], //dolphin
        [1.8, 1.5] //polarbear
    ]
    
    // 각 animal memo의 Asset image 이름.
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
}

// MARK: Private Extension

private extension MainViewController {
    func addSubviewsWithFrame() {
        backImageView.frame = view.bounds
        view.addSubview(backImageView)
        
        for i in 0...4 {
            let ratio = memosRatio[i]
            let button = memoButton(CGPoint(x: .screenW / ratio[0], y: .screenH / ratio[1]), imageName: memosAnimal[i])
            button.tag = i
            button.addTarget(self, action: #selector(zoomInMemo(_:)), for: .touchUpInside)
            backImageView.addSubview(button)
            memoButtons.append(button)
        }
    }
    
    @objc func zoomInMemo(_ sender: UIButton) {
        let ratio = memosRatio[sender.tag]
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.backImageView.frame.size = .backDoubleSize
            self.backImageView.frame.origin = CGPoint(
                x: -self.backImageView.frame.width / ratio[0] + .screenW/4.2,
                y: -self.backImageView.frame.height / ratio[1] + .screenH/3
            )
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
        sender.isUserInteractionEnabled = false
    }
    
    @objc func zoomOutAction() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.backImageView.frame = self.view.bounds
            let _ = self.memoButtons.map { button in
                let tag = button.tag
                button.frame = CGRect(
                    origin: CGPoint(
                        x: .screenW / self.memosRatio[tag][0],
                        y: .screenH / self.memosRatio[tag][1]
                        ),
                    size: .memoSize
                    )
                button.isUserInteractionEnabled = true
            }
        }
    }
}

extension CGFloat {
    
    static let screenW = UIScreen.main.bounds.width
    
    static let screenH = UIScreen.main.bounds.height
    
    static let hund = UIScreen.main.bounds.width / 3.9 //iPhone 13기준 100
    
    static let ten = UIScreen.main.bounds.width / 39 //iPhone 13기준 10
}

extension CGSize {
    
    static let memoSize = CGSize(width: .screenW / 3, height: .screenW / 3.2)
    
    static let memoDoubleSize = CGSize(width: .screenW / 1.5, height: .screenW / 1.6)
    
    static let animalSize = CGSize(width: .screenW / 3, height: .screenH / 3)
    
    static let backDoubleSize = CGSize(width: .screenW * 2, height: .screenH * 2)
    
}
