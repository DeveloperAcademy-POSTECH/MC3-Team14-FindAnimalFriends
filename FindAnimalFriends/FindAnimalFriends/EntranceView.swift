//
//  EntranceView.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/25.
//

import UIKit

class EntranceView: UIView {
//    button.titleLabel?.font = UIFont(name: "KOTRA HOPE", size: .screenW*0.06)
    
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
    
    lazy var pushButton: UIButton = { //FIXME: Sub UIView 자체에서 navigation push 하는 법?이 있나? 없을듯
        let button = UIButton() //type: .system하면 기본 highlighted 효과 있음.
        button.setTitle("퀴즈 풀기", for: .normal)
        button.titleLabel?.font = UIFont(name: "KOTRA HOPE", size: .ten*2.4)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.appColor(.primaryBrown)
        button.layer.cornerRadius = 10
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
            pushButton.widthAnchor.constraint(equalToConstant: .hund*2.7),
            pushButton.heightAnchor.constraint(equalToConstant: .hund*0.7)
        ])
    }
}

// TODO: convenience init, required init, override init
// to mizz - 오늘 말해준 required 꼭 필요하진않을지도?

// UIControl.State -> 어떤 상태일 때 어떤 setting을 할 것인지 정할 수 있다.
