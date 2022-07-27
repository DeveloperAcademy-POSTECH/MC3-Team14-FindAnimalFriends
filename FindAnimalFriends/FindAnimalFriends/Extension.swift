//
//  Extension.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/23.
//

import AVFoundation
import UIKit

extension CGFloat {
    
    static let screenW = UIScreen.main.bounds.width
    
    static let screenH = UIScreen.main.bounds.height
    
    static let hund = UIScreen.main.bounds.width / 3.9 //iPhone 13기준 100
    
    static let ten = UIScreen.main.bounds.width / 39 //iPhone 13기준 10
}

extension CGSize {
    
    // 축소일 때 동물메모의 크기
    static let memoSize = CGSize(width: .screenW / 3, height: .screenW / 3.2)
    
    // 확대일 때 동물메모의 크기
    static let memoDoubleSize = CGSize(width: .screenW / 1.5, height: .screenW / 1.6)
    
    // 축소일 때 checkmark lottie 크기
    static let checkSize = CGSize(width: .screenW / 6, height: .screenW / 6)
    
    // 확대일 때 checkmark lottie 크기
    static let checkDoubleSize = CGSize(width: .screenW / 3, height: .screenW / 3)
    
    // 확대일 때 배경의 크기
    static let backDoubleSize = CGSize(width: .screenW * 2, height: .screenH * 2)
    
    // 축소일 때 mask의 크기
    static let maskSize = CGSize(width: .screenW / 2, height: .screenW / 2)
    
    // 확대일 때 mask의 크기
    static let maskDoubleSize = CGSize(width: .screenW, height: .screenW)
    
}

enum AssetsColor {
    case primaryGreen
    case primaryRed
    case primaryBrown
    case primaryOrange
    case primaryWhite
    case memoWhite
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .primaryGreen:
            return #colorLiteral(red: 0.1607843137, green: 0.8117647059, blue: 0.2196078431, alpha: 1)
        case .primaryRed:
            return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        case .primaryBrown:
            return #colorLiteral(red: 0.568627451, green: 0.2117647059, blue: 0.1137254902, alpha: 1)
        case .primaryOrange:
            return #colorLiteral(red: 0.9058823529, green: 0.6352941176, blue: 0.3294117647, alpha: 1)
        case .primaryWhite:
            return #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        case .memoWhite:
            return #colorLiteral(red: 0.984313786, green: 0.984313786, blue: 0.984313786, alpha: 1)
        }
    }
}

extension UIButton {
    func custom(_ title: String, titleColor: UIColor, size fontSize: CGFloat, backColor: UIColor) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(name: "KOTRA HOPE", size: fontSize)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backColor
        self.layer.cornerRadius = 8
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.4
    }
}

extension UILabel {
    func subtitleVersion() {
        self.numberOfLines = 0
        self.font = UIFont(name: "KOTRA HOPE", size: .ten*2)
        self.textColor = .white
        self.backgroundColor = .black.withAlphaComponent(0.8)
        self.textAlignment = .left
    }
}

class AVPlay {

    static let shared = AVPlay()

    var player: AVAudioPlayer!

    func playSound(sound: String) {
         let url = Bundle.main.url(forResource: sound, withExtension: "wav")
         guard url != nil else{
             return
         }
         do{
             player = try AVAudioPlayer(contentsOf: url!)
             player?.play()
         } catch {
             print("\(error)")
         }
     }
}
