//
//  CheckmarkLottieView.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/27.
//

import UIKit
import Lottie

class CheckmarkLottieView: UIView {

    lazy var checkView: AnimationView = {
        let lottieView = AnimationView(name: "checkmark")
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .playOnce
        lottieView.backgroundBehavior = .pauseAndRestore
        return lottieView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(checkView)
        checkView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        checkView.frame = bounds //bounds~!
//    }
}
