//
//  ViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit

extension CGFloat {
    static let screenW = UIScreen.main.bounds.width
    static let screenH = UIScreen.main.bounds.height
}

extension CGRect {
    static let fullFrame = CGRect(x: 0, y: 0, width: .screenW, height: .screenH)
}

extension CGSize {
    static let memoSize = CGSize(width: .screenW / 3, height: .screenW / 3)
}

class MainViewController: UIViewController {
    
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
    }
    
    func memoButton(_ origin: CGPoint) -> UIButton {
        let button = UIButton(frame: CGRect(origin: origin, size: .memoSize))
        
        return button
    }
}
