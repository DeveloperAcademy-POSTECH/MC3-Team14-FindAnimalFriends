//
//  QuizExplanationViewController.swift
//  FindAnimalFriends
//
//  Created by MBSoo on 2022/07/27.
//

import UIKit

class QuizExplanationViewController: UIViewController {

    private var quizExplanationView : QuizExplanationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        quizExplanationView = QuizExplanationView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        quizExplanationView!.completeButton.addTarget(self, action: #selector(closeQuizExplanationView), for: .touchUpInside)
        view.addSubview(quizExplanationView!)
    }
    @objc func closeQuizExplanationView() {
        quizExplanationView!.removeFromSuperview()
    }
    

}
