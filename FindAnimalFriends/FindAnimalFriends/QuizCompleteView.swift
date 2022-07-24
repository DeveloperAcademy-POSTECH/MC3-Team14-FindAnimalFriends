//
//  QuizResultCollectView.swift
//  FindAnimalFriends
//
//  Created by heojaenyeong on 2022/07/23.
//
//MARK: converterWidth함수(아이폰 13 기준으로 정해진 마진과 같은 값을 넣으면 실 기기의 width값에 비례한 값으로 변환)
func converterWidth(getWidth: CGFloat) -> CGFloat {
    let standardWidth:CGFloat = 390
    let boundWidth:CGFloat = UIScreen.main.bounds.width
    return (boundWidth * getWidth)/standardWidth
    
}

//MARK: converterHeight함수(아이폰 13 기준으로 정해진 마진과 같은 값을 넣으면 실 기기의 height값에 비례한 값으로 변환)
func converterHeight(getHeight: CGFloat) -> CGFloat {
    let standardHeight:CGFloat = 844
    let boundHeight:CGFloat = UIScreen.main.bounds.height
    return (boundHeight * getHeight)/standardHeight
}

import Foundation
import UIKit
class QuizCompleteView: UIView {
    let animalName: String?
    
    //MARK: animalImageView
    private lazy var animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: animalName ?? "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: assistantImage
    private let assistantImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "assistant2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: detectiveImage
    private let detectiveImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "detective3")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        button.setTitle("동물 친구를 찾았어요 :)", for: .normal)
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
    required init(frame: CGRect, animalName: String) {
        self.animalName = animalName
        super.init(frame: frame)
        addSubview(blackView)
        blackView.addSubview(whiteView)
        whiteView.addSubview(animalImageView)
        whiteView.addSubview(assistantImage)
        whiteView.addSubview(detectiveImage)
        whiteView.addSubview(completeButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let animalImageViewConstraints = [
            animalImageView.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: converterHeight(getHeight: 39)),
            animalImageView.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -1*converterHeight(getHeight: 185)),
            animalImageView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: converterWidth(getWidth: 38)),
            animalImageView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -1*converterWidth(getWidth: 38))
        ]
        
        let assisstantImageViewConstraints = [
            assistantImage.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: converterHeight(getHeight: 204)),
            assistantImage.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -1*converterHeight(getHeight: 80)),
            assistantImage.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: converterWidth(getWidth: 25)),
            assistantImage.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -1*converterWidth(getWidth: 225))
        ]
        
        let detectiveImageViewConstraints = [
            detectiveImage.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: converterHeight(getHeight: 200)),
            detectiveImage.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -1*converterHeight(getHeight: 83)),
            detectiveImage.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: converterWidth(getWidth: 208)),
            detectiveImage.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -1*converterWidth(getWidth: 25))
        ]
        
        let whiteViewConstraints = [
            whiteView.topAnchor.constraint(equalTo: topAnchor, constant: converterHeight(getHeight: 235)),
            whiteView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1*converterHeight(getHeight: 200)),
            whiteView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: converterWidth(getWidth: 33)),
            whiteView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1*converterWidth(getWidth: 33))
        ]
        
        let blackViewConstraints = [
            blackView.widthAnchor.constraint(equalToConstant: bounds.width),
            blackView.heightAnchor.constraint(equalToConstant: bounds.height)
        ]
        let completeButtonConstraints = [
            completeButton.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: converterHeight(getHeight: 293)),
            completeButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant:  -1*converterHeight(getHeight: 45)),
            completeButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: converterWidth(getWidth: 25)),
            completeButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -1*converterWidth(getWidth: 25)),
        ]
        NSLayoutConstraint.activate(animalImageViewConstraints)
        NSLayoutConstraint.activate(assisstantImageViewConstraints)
        NSLayoutConstraint.activate(detectiveImageViewConstraints)
        NSLayoutConstraint.activate(blackViewConstraints)
        NSLayoutConstraint.activate(whiteViewConstraints)
        NSLayoutConstraint.activate(completeButtonConstraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
