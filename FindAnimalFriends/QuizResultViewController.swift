//
//  QuizResultViewController.swift
//  FindAnimalFriends
//
//  Created by heojaenyeong on 2022/07/23.
//

import Foundation
import UIKit
class QuizResultViewController: UIViewController{
    func blackView(bounds:CGRect) -> UIView{
        let view = UIView(frame: bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }
    
    func whiteView()->UIView{
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func okButton()-> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .green
        //button.addTarget(self, action: #selector(CloseCollectView), for: .touchUpInside)
        return button
    }
    
    var CollectView:UIView {
        let quizResultCollectView = blackView(bounds: view.bounds)
        let quizResultCollectWhiteView = whiteView()
        let okButton = okButton()
        okButton.addTarget(self, action: #selector(CloseCollectView), for: .touchUpInside)
        view.addSubview(quizResultCollectView)
        quizResultCollectView.addSubview(quizResultCollectWhiteView)
        quizResultCollectWhiteView.addSubview(okButton)
        
        NSLayoutConstraint.activate([
            quizResultCollectWhiteView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            quizResultCollectWhiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quizResultCollectWhiteView.widthAnchor.constraint(equalToConstant: 300),
            quizResultCollectWhiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        return quizResultCollectView
    }
    
    var testButton: UIButton = {
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
    }
    @objc func AddCollectView(){
        view.addSubview(CollectView)
        print("aaa")
    }
    @objc func CloseCollectView(){
        CollectView.removeFromSuperview()
        print("bbb")
    }

    
}
