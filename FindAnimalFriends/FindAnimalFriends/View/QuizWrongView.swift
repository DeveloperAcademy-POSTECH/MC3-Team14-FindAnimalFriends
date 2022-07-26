//
//  QuizResultCollectView.swift
//  FindAnimalFriends
//
//  Created by heojaenyeong on 2022/07/23.
//

import Foundation
import UIKit
class QuizWrongView: UIView {
    
    //MARK: assistantImage
    private let assistantImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "assistantImage3")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: assistantImage
    private let disappointLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "탐정님... 아무래도 아닌거 같아요 ;-("
        label.font = UIFont(name: "KOTRA HOPE", size: converterFontSize(getFontSize: 24))
        label.frame = CGRect(x: converterWidth(getWidth: 22), y: converterHeight(getHeight: 44), width: converterWidth(getWidth: 280), height: converterHeight(getHeight: 28))
        return label
    }()
    
    //MARK: blackView
    private let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: whiteView
    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: completeButton
    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시 가르쳐줄게!", for: .normal)
        button.titleLabel?.font = UIFont(name: "KOTRA HOPE", size: 24)
        button.titleLabel?.textColor = .white
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 231/255, green: 162/255, blue: 84/255, alpha: 100)//hexcode: E7A254
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        //뷰 그림자부분
        button.layer.shadowColor = UIColor.black.cgColor // 그림자색깔
        button.layer.masksToBounds = false  // 뷰 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지결정하는 변수 그림자는 밖에 그려지는 것이므로(UIView를 벗어나므로) false로 설정함
        //button.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 위치조정
        button.layer.shadowOffset = CGSize(width: 1.0, height: 4.0) // 그림자의 위치조정
        button.layer.shadowRadius = 2//그림자의 반경
        button.layer.shadowOpacity = 0.4 // 그림자의 alpha값
        
        //https://gonslab.tistory.com/23 참고했음
        
        return button
        
    }()

    //MARK:
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(blackView)
        blackView.addSubview(assistantImage)
        blackView.addSubview(whiteView)
        whiteView.addSubview(disappointLabel)
        whiteView.addSubview(completeButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
    
        let assisstantImageViewConstraints = [
            assistantImage.topAnchor.constraint(equalTo: blackView.topAnchor, constant: converterHeight(getHeight: 187)),
            assistantImage.bottomAnchor.constraint(equalTo: blackView.bottomAnchor, constant: -1*converterHeight(getHeight: 507)),
            assistantImage.leadingAnchor.constraint(equalTo: blackView.leadingAnchor, constant: converterWidth(getWidth: 37)),
            assistantImage.trailingAnchor.constraint(equalTo: blackView.trailingAnchor, constant: -1*converterWidth(getWidth: 257))
        ]
        
        let whiteViewConstraints = [
            whiteView.topAnchor.constraint(equalTo: topAnchor, constant: converterHeight(getHeight: 301)),
            whiteView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1*converterHeight(getHeight: 338)),
            whiteView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: converterWidth(getWidth: 33)),
            whiteView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1*converterWidth(getWidth: 33))
        ]
        
        let blackViewConstraints = [
            blackView.widthAnchor.constraint(equalToConstant: bounds.width),
            blackView.heightAnchor.constraint(equalToConstant: bounds.height)
        ]
        
        let completeButtonConstraints = [
            completeButton.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: converterHeight(getHeight: 123)),
            completeButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant:  -1*converterHeight(getHeight: 32)),
            completeButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: converterWidth(getWidth: 25)),
            completeButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -1*converterWidth(getWidth: 25)),
        ]
        NSLayoutConstraint.activate(assisstantImageViewConstraints)
        NSLayoutConstraint.activate(blackViewConstraints)
        NSLayoutConstraint.activate(whiteViewConstraints)
        NSLayoutConstraint.activate(completeButtonConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
