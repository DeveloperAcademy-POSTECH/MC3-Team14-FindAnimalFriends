//
//  ViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit


class MainViewController: UIViewController {
    
    private let memosOrigin = [
        CGPoint(x: .screenW / 10, y: .screenH / 8),
        CGPoint(x: .screenW / 1.8, y: .screenH / 6),
        CGPoint(x: .screenW / 3, y: .screenH / 2.5),
        CGPoint(x: .screenW / 10, y: .screenH / 1.5),
        CGPoint(x: .screenW / 1.8, y: .screenH / 1.4),
    ]
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainBackground")
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addSubviewsWithFrame()
    }
}

private extension MainViewController {
    func addSubviewsWithFrame() {
        view.addSubview(backImageView)
        backImageView.frame = .fullFrame
        
        for origin in memosOrigin {
            let button = memoButton(origin)
            view.addSubview(button)
        }
    }
    
    func memoButton(_ origin: CGPoint) -> UIButton {
        let button = UIButton(frame: CGRect(origin: origin, size: .memoSize))
        button.setImage(UIImage(named: "memo"), for: .normal)
        return button
    }
}

extension CGFloat {
    static let screenW = UIScreen.main.bounds.width
    static let screenH = UIScreen.main.bounds.height
}

extension CGRect {
    static let fullFrame = CGRect(x: 0, y: 0, width: .screenW, height: .screenH)
}

extension CGSize {
    static let memoSize = CGSize(width: .screenW / 2.5, height: .screenW / 2.9)
}
