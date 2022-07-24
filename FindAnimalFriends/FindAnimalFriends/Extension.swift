//
//  Extension.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/23.
//

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
    
    // 확대일 때 배경의 크기
    static let backDoubleSize = CGSize(width: .screenW * 2, height: .screenH * 2)
    
    // 축소일 때 mask의 크기
    static let maskSize = CGSize(width: .screenW / 2, height: .screenW / 2)
    
    // 확대일 때 mask의 크기
    static let maskDoubleSize = CGSize(width: .screenW, height: .screenW)
    
}
