//
//  LaunchScreenController.swift
//  FindAnimalFriends
//
//  Created by Byeon jinha on 2022/07/23.
//

import UIKit

class LaunchScreenController: UIViewController, UIScrollViewDelegate {
    var timeValue: Int = 0
    // MARK: 시간경과에 따른 애니메이션 함수
    func timeCount() {
            (withDuration: 0.5, delay: 0.5) { [self] in
            self.findLabel.layer.opacity = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.animalLabel.layer.opacity = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.5) {
                    self.friendsLabel.layer.opacity = 1
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.view.layer.opacity = 0
                    }
                }
            }
        }
    }

    let image: UIImage = UIImage(named: "detectiveImage1")!
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    lazy var findLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: width*0.15, y: height*0.18, width: width, height: height*0.07))
        label.text = "찾아라!"
        label.font = UIFont(name: "KOTRA HOPE", size: height*0.06)
        label.layer.opacity = 0
        return label
    }()
    lazy var animalLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: width*0.4, y: height*0.26, width: width, height: height*0.07))
        label.text = "동물"
        label.textColor = .green
        label.font = UIFont(name: "KOTRA HOPE", size: height*0.06)
        label.layer.opacity = 0
        return label
    }()
    lazy var friendsLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: width*0.55, y: height*0.34, width: width, height: height*0.07))
        label.text = "친구들"
        label.font = UIFont(name: "KOTRA HOPE", size: height*0.06)
        label.layer.opacity = 0
        return label
    }()
   
    lazy var detectiveImage: UIImageView = {
        let posX: CGFloat = (width*0.4)/2
        let posY: CGFloat = (height*0.9)/2
        let detectiveImage: UIImageView = UIImageView(frame: CGRect(x: posX, y: posY, width: width*0.6, height: height*0.4))
        detectiveImage.image = self.image
        
        return detectiveImage
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(findLabel)
        view.addSubview(animalLabel)
        view.addSubview(friendsLabel)
        view.addSubview(detectiveImage)
        timeCount()
    }
}


