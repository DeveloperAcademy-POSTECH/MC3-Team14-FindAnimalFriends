//
//  ReadyView.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/26.
//

import UIKit

class ReadyView: UIView {
    
    private let subtitle = "자... 그럼 시작해볼까?"
    
    private let detectiveView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detectiveImage3"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        addSubview(detectiveView)
        addSubview(textLabel)
        makeConstraints()
        setupCodeName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCodeName() {
        DispatchQueue.main.async {
            for i in self.subtitle {
                self.textLabel.text! += "\(i)"
                RunLoop.current.run(until: Date() + 0.05)
            }
        }
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            detectiveView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.screenH / 10),
            detectiveView.leftAnchor.constraint(equalTo: rightAnchor, constant: -.screenW / 3),
            detectiveView.widthAnchor.constraint(equalToConstant: .screenW / 4),
            detectiveView.heightAnchor.constraint(equalToConstant: .screenW / 3),
            
            textLabel.rightAnchor.constraint(equalTo: detectiveView.leftAnchor, constant: -.hund / 2),
            textLabel.centerYAnchor.constraint(equalTo: detectiveView.centerYAnchor)
        ])
    }
}
