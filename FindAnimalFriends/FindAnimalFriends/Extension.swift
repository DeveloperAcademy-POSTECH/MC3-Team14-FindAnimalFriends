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
    
    static let memoSize = CGSize(width: .screenW / 3, height: .screenW / 3.2)
    
    static let memoDoubleSize = CGSize(width: .screenW / 1.5, height: .screenW / 1.6)
    
    static let backDoubleSize = CGSize(width: .screenW * 2, height: .screenH * 2)
    
}

enum AssetsColor {
  case primaryGreen
  case primaryRed
  case primaryBrown
  case primaryOrange
  case primaryWhite
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
    }
  }
}


// MARK: Sound 관련 변수, 함수
var player: AVAudioPlayer!
func playSound(sound: String){
     let url = Bundle.main.url(forResource: sound, withExtension: "wav")
     guard url != nil else{
         return
     }
     do{
         player = try AVAudioPlayer(contentsOf: url!)
         player?.play()
     }catch{
         print("\(error)")
     }
 }
