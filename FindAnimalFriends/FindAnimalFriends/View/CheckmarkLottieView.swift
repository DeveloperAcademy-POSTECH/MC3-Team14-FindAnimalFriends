//
//  CheckmarkLottieView.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/27.
//

import UIKit
import Lottie

class CheckmarkLottieView: UIView {

    private lazy var lottieView: AnimationView = {
        let lottieView = AnimationView(name: "checkmark")
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .playOnce
        lottieView.backgroundBehavior = .pauseAndRestore
        return lottieView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lottieView)
        lottieView.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
