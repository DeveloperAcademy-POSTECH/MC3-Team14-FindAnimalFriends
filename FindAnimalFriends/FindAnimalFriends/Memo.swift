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
    
    var backImageFrame: CGRect { // memoRatio와 isZoomMode를 기반으로 배경의 좌표와 크기를 반환
        if isZoomMode {
            return CGRect(
                origin: CGPoint(
                    x: -.screenW*2 / memoRatio[0] + .screenW/5,
                    y: -.screenH*2 / memoRatio[1] + .screenH/3
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
                    x: .screenW / memoRatio[0] - 25,
                    y: .screenH / memoRatio[1] - 25
                ),
                size: .maskSize
            )
        )
    }
    
    var inMaskLayer: UIBezierPath { // memoRatio를 기반으로 확대 시의 mask Circle 크기를 반환
        return UIBezierPath(
            ovalIn: CGRect(
                origin: CGPoint(
                    x: .screenW * 2 / memoRatio[0] - 50,
                    y: .screenH * 2 / memoRatio[1] - 50
                ),
                size: .maskDoubleSize
            )
        )
    }
}
