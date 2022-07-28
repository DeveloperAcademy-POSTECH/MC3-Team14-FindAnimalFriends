//
//  EntranceView.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/25.
//

import UIKit

class EntranceView: UIView {
    
    var animalName: String?
    
    var animalDescription: String = ""
    
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
    
    lazy var pushButton: UIButton = { //FIXME: Sub UIView 자체에서 navigation push 하는 법?이 있나?
        let button = UIButton() //type: .system하면 기본 highlighted 효과 있음.
        button.custom("퀴즈 풀기", titleColor: .white, size: .ten*2.4, backColor: .appColor(.primaryBrown))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.subtitleVersion()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cancelButton)
        addSubview(textLabel)
        addSubview(pushButton)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComments() {
        makeDescription() //설명글귀 만들기
        isClear() //재시도인지를 판단하고 버튼title 및 자막멘트 재설정
        
        DispatchQueue.main.async {
            AVPlay.shared.playSound(sound: "typingSound")
            for i in self.animalDescription {
                self.textLabel.text! += "\(i)"
                RunLoop.current.run(until: Date() + 0.05)
            }
        }
    }
    
    func isClear() {
        let nowIndex = QuizDao().getAnimalDict()[animalName ?? ""] ?? 0
        let openIndex = UserDefaults.standard.integer(forKey: "clear")
        if nowIndex < openIndex {
            pushButton.setTitle("다시 풀기", for: .normal)
            animalDescription = animalDescription.replacingOccurrences(of: "실종날짜: yy.MM.dd", with: "동물친구가 돌아왔어요~")
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: centerYAnchor, constant: -.screenH/5),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.screenW/5),
            
            textLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: .screenW/6),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            pushButton.topAnchor.constraint(equalTo: centerYAnchor, constant: .screenW/3),
            pushButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pushButton.widthAnchor.constraint(equalToConstant: .hund*2.7),
            pushButton.heightAnchor.constraint(equalToConstant: .hund*0.7)
        ])
    }
    
    private func makeDescription() {
        switch animalName {
        case "tiger":
            animalDescription = "코드네임: 호랭이\n실종날짜: yy.MM.dd"
        case "elephant":
            animalDescription = "코드네임: 코봉이\n실종날짜: yy.MM.dd"
        case "panda":
            animalDescription = "코드네임: 쿵푸팬더\n실종날짜: yy.MM.dd"
        case "dolphin":
            animalDescription = "코드네임: 돌고래\n실종날짜: yy.MM.dd"
        case "polarbear":
            animalDescription = "코드네임: 북극이\n실종날짜: yy.MM.dd"
        default:
            break
        }
    }
}

// TODO: convenience init, required init, override init
// to mizz - 오늘 말해준 required 꼭 필요하진않을지도?

// UIControl.State -> 어떤 상태일 때 어떤 setting을 할 것인지 정할 수 있다.
