//
//  QuizResultViewController.swift
//  FindAnimalFriends
//
//  Created by heojaenyeong on 2022/07/23.
//

import Foundation
import UIKit
class QuizCompleteViewController: UIViewController {
    
    private var quizCompleteView: QuizCompleteView?
    private var getAnimalName: String = "polarbear"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        quizCompleteView = QuizCompleteView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), animalName: getAnimalName)
        quizCompleteView!.completeButton.addTarget(self, action: #selector(closeQuizCompleteView), for: .touchUpInside)
        view.addSubview(quizCompleteView!)
    }
    
    @objc func closeQuizCompleteView() {
        quizCompleteView!.removeFromSuperview()
    }
    
    func setAnimalName(getAnimalName: String) {
        self.getAnimalName = getAnimalName
    }
    
}

