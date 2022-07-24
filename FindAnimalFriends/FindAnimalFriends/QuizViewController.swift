//
//  ViewController.swift
//  BookPage
//
//  Created by Dongjin Jeon on 2022/07/22.
//

import UIKit

class QuizViewController: UIViewController {
    
    var index: Int?
    let quizIndicatorLabel = UILabel()
    let quizLabel = UILabel()
    let backImgView = UIImageView(image: UIImage(named: "memoSpring"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawBackground()
        drawIndicateLable()
        drawQuiz()
    }
    
    func drawQuiz() {
        self.view.addSubview(quizLabel)
        let attributedString = NSMutableAttributedString.init(string: "\(sampleQuiz[index ?? 0])")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        quizLabel.attributedText = attributedString
        quizLabel.font = UIFont(name: "KOTRA HOPE", size: 36)
        quizLabel.translatesAutoresizingMaskIntoConstraints = false
        quizLabel.topAnchor.constraint(equalTo: self.quizIndicatorLabel.bottomAnchor, constant: 10).isActive = true
        quizLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        quizLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        quizLabel.numberOfLines = 0
    }
    
    func drawBackground() {
        self.view.addSubview(backImgView)
        backImgView.translatesAutoresizingMaskIntoConstraints = false
        backImgView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        backImgView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        self.view.backgroundColor = UIColor.appColor(AssetsColor.memoWhite)
    }
    
    func drawIndicateLable() {
        self.view.addSubview(quizIndicatorLabel)
        quizIndicatorLabel.translatesAutoresizingMaskIntoConstraints = false
        quizIndicatorLabel.text = "\((index ?? 0)+1)/\(sampleQuiz.count)"
        quizIndicatorLabel.font = UIFont(name: "KOTRA HOPE", size: 36)
        quizIndicatorLabel.textColor = .black
        quizIndicatorLabel.topAnchor.constraint(equalTo: backImgView.bottomAnchor).isActive = true
        quizIndicatorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 20).isActive = true
        quizIndicatorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        quizIndicatorLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        quizIndicatorLabel.adjustsFontSizeToFitWidth = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

