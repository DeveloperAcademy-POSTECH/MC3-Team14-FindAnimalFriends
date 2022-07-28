//
//  PartPopperLotieView.swift
//  FindAnimalFriends
//
//  Created by heojaenyeong on 2022/07/28.
//

import UIKit
import Lottie

class PartyPopperLotieView: UIView {

    lazy var partyPopper: AnimationView = {
        let lottieView = AnimationView(name: "party-popper")
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.backgroundBehavior = .pauseAndRestore
        return lottieView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(partyPopper)
        partyPopper.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        checkView.frame = bounds //bounds~!
//    }
}
