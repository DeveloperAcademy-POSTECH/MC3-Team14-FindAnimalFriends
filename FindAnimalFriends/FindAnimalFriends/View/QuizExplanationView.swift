//
//  QuizExplanationView.swift
//  FindAnimalFriends
//
//  Created by MBSoo on 2022/07/27.
//

import UIKit

class QuizExplanationView: UIView {
    
    var quizExplanation = "호랑이가 괜히 백수의 왕이라고 불리는게 아니지. 점프할때는 무려 3미터 이상도 뛸수 있고, 다른 고양잇과 동물들처럼 나무타기도 잘하지만, 물을 싫어하는 다른 고양잇과 동물들과는 달리 수영도 잘한단다."
    // quiz에서 던져주는 설명으로 받을 예정
    
    //MARK: UIComponents
    private let detectiveImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "detectiveImage3")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = self.quizExplanation
        label.font = UIFont(name: "KOTRA HOPE", size: converterFontSize(getFontSize: 24))
        label.frame = CGRect(x: converterWidth(getWidth: 22), y: converterHeight(getHeight: 22), width: converterWidth(getWidth: 280), height: converterHeight(getHeight: .screenH/3.5))
        label.numberOfLines = 0
        return label
    }()
    
    private let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.custom("다음 문제로", titleColor: .white, size: 24, backColor: UIColor(red: 231/255, green: 162/255, blue: 84/255, alpha: 100))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()

    //MARK: Life Cycle Method
    required init(frame: CGRect, quizExplanation: String) {
        super.init(frame: frame)
        self.quizExplanation = quizExplanation
        addSubview(blackView)
        blackView.addSubview(whiteView)
        blackView.addSubview(detectiveImage)
        whiteView.addSubview(explanationLabel)
        whiteView.addSubview(completeButton)
        applyConstraints()
        blackView.sendSubviewToBack(detectiveImage)
        // detectiveImage 가려지게 하기
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Func
    private func applyConstraints() {
    
        let blackViewConstraints = [
            blackView.widthAnchor.constraint(equalToConstant: bounds.width),
            blackView.heightAnchor.constraint(equalToConstant: bounds.height)
        ]
        let whiteViewConstraints = [
            whiteView.topAnchor.constraint(equalTo: blackView.topAnchor, constant: converterHeight(getHeight: .hund*2)),
            whiteView.bottomAnchor.constraint(equalTo: blackView.bottomAnchor, constant: -1*converterHeight(getHeight: .hund*3)),
            whiteView.leadingAnchor.constraint(equalTo: blackView.leadingAnchor, constant: converterWidth(getWidth: 33)),
            whiteView.trailingAnchor.constraint(equalTo: blackView.trailingAnchor, constant: -1*converterWidth(getWidth: 33))
        ]
        let detectiveImageViewConstraints = [
            detectiveImage.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: converterHeight(getHeight: -75)),
            detectiveImage.bottomAnchor.constraint(equalTo: whiteView.topAnchor, constant: converterHeight(getHeight: 20)),
            detectiveImage.leadingAnchor.constraint(equalTo: blackView.leadingAnchor, constant: converterWidth(getWidth: 37)),
            detectiveImage.trailingAnchor.constraint(equalTo: blackView.trailingAnchor, constant: -1*converterWidth(getWidth: 257))
        ]
        let completeButtonConstraints = [
            completeButton.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: converterHeight(getHeight: .hund*2.5)),
            completeButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant:  -1*converterHeight(getHeight: 32)),
            completeButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: converterWidth(getWidth: 25)),
            completeButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -1*converterWidth(getWidth: 25)),
        ]
        
        NSLayoutConstraint.activate(blackViewConstraints)
        NSLayoutConstraint.activate(whiteViewConstraints)
        NSLayoutConstraint.activate(detectiveImageViewConstraints)
        NSLayoutConstraint.activate(completeButtonConstraints)
    }
}
