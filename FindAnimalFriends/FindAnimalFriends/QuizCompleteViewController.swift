//
//  QuizResultViewController.swift
//  FindAnimalFriends
//
//  Created by heojaenyeong on 2022/07/23.
//

import Foundation
import UIKit
class QuizCompleteViewController: UIViewController{
    
    private var quizCompleteView : QuizCompleteView?
    lazy var testButton: UIButton = {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let testButton: UIButton = UIButton()
        testButton.translatesAutoresizingMaskIntoConstraints = true
        testButton.backgroundColor = .orange
        testButton.clipsToBounds = true
        testButton.addTarget(self, action: #selector(AddCollectView), for: .touchUpInside)
        testButton.setTitle("testButton", for: .normal)
        testButton.frame = CGRect(x: screenWidth*0.1, y: screenHeight*0.1, width: 300, height: 100)
        return testButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(testButton)
        quizCompleteView = QuizCompleteView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), animalName: "polarbear")
        quizCompleteView!.completeButton.addTarget(self, action: #selector(CloseCollectView), for: .touchUpInside)
    }
    @objc func CloseCollectView(){
        quizCompleteView!.removeFromSuperview()
    }
    @objc func AddCollectView(){
        view.addSubview(quizCompleteView!)
    }
    
    
}

