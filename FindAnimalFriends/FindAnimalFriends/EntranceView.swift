//
//  EntranceView.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/25.
//

import UIKit

class EntranceView: UIView {
    
    var animal: String?

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: .hund/2, weight: .black), forImageIn: .normal
        )
        button.tintColor = .secondaryLabel
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("퀴즈풀기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.backgroundColor = UIColor.red.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cancelButton)
        addSubview(pushButton)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: centerYAnchor, constant: -.screenH/5),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.screenW/5),
            
            pushButton.topAnchor.constraint(equalTo: centerYAnchor, constant: .screenW/3),
            pushButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pushButton.widthAnchor.constraint(equalToConstant: .screenW*0.7),
            pushButton.heightAnchor.constraint(equalToConstant: .hund)
        ])
    }
}

// TODO: convenience init, required init, override init
