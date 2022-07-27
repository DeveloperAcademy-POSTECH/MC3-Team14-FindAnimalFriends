//
//  QuizResultViewController.swift
//  FindAnimalFriends
//
//  Created by heojaenyeong on 2022/07/24.
//

import Foundation
import UIKit
class QuizWrongViewController: UIViewController {
    
    private var quizWrongView : QuizWrongView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        quizWrongView = QuizWrongView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        quizWrongView!.completeButton.addTarget(self, action: #selector(closeQuizWrongView), for: .touchUpInside)
        view.addSubview(quizWrongView!)
    }
    @objc func closeQuizWrongView() {
        quizWrongView!.removeFromSuperview()
    }
    
    
}

