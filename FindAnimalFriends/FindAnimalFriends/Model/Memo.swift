//
//  Memo.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/24.
//

import UIKit

enum Zoom {
    case zoomIn
    case zoomOut
    
    static var status: Zoom = .zoomOut
}

struct Memo {
    // Zoom case 상태에 따라 판별
    var isZoomMode: Bool {
        if Zoom.status == .zoomIn {
            return true
        } else {
            return false
        }
    }
    
    var memoRatio: [CGFloat] // memo 자신의 화면에서의 비율
    var memoAnimal: String // memo 자신의 동물 이름
    
    var memoFrame: CGRect { // memoRatio와 isZoomMode를 기반으로 자신의 좌표와 크기를 반환
        let mul = isZoomMode ? 2.0 : 1.0
        return CGRect(
            origin: CGPoint(
                x: .screenW * mul / memoRatio[0],
                y: .screenH * mul / memoRatio[1]),
            size: isZoomMode ? .memoDoubleSize : .memoSize
        )
    }
    
    // 하위 모든 Computed property의 크기는 상단 memoFrame의 크기에 비례한다.
    var lottieFrame: CGRect {
        return CGRect(
            origin: CGPoint(
                x: memoFrame.origin.x + memoFrame.width/2,
                y: memoFrame.origin.y + memoFrame.width/2
            ),
            size: isZoomMode ? .checkDoubleSize : .checkSize
        )
    }
    
    var backImageFrame: CGRect { // memoRatio와 isZoomMode를 기반으로 배경의 좌표와 크기를 반환
        if isZoomMode {
            return CGRect(
                origin: CGPoint(
                    x: -memoFrame.origin.x + .screenW/5,
                    y: -memoFrame.origin.y + .screenH/3
                ),
                size: .backDoubleSize
            )
        } else {
            return UIScreen.main.bounds
        }
    }
    
    var outMaskLayer: UIBezierPath { // memoRatio를 기반으로 축소 시의 mask Circle 크기를 반환
        return UIBezierPath(
            ovalIn: CGRect(
                origin: CGPoint(
                    x: memoFrame.origin.x - .screenW/10,
                    y: memoFrame.origin.y - .screenW/10
                ),
                size: .maskSize
            )
        )
    }
    
    var inMaskLayer: UIBezierPath { // memoRatio를 기반으로 확대 시의 mask Circle 크기를 반환
        return UIBezierPath(
            ovalIn: CGRect(
                origin: CGPoint(
                    x: memoFrame.origin.x - .screenW/5,
                    y: memoFrame.origin.y - .screenW/5
                ),
                size: .maskDoubleSize
            )
        )
    }
}
