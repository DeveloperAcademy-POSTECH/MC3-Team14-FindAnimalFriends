//
//  ViewController.swift
//  BookPage
//
//  Created by Dongjin Jeon on 2022/07/22.
//

import UIKit

class QuizViewController: UIViewController {
    
    // 몇 번째 퀴즈인지 나타내는 변수
    var index: Int?
    
    var animalName: String?
    
    // 퀴즈를 나타내는 변수
    var quiz: Quiz?
    
    // 퀴즈의 정답 버튼 배열
    private var quizAnswers: [String] {
        let quizAnswer = quiz?.answers
        
        return quizAnswer ?? [""]
    }
    
    // 필요한 버튼의 개수
    private var buttonCount = 4
    
    // 전체 퀴즈의 개수
    private var totalQuizCount = 5
    
    // 총 몇 개의 퀴즈인지 나태내는 Label
    private let quizIndicatorLabel = UILabel()
    // 퀴즈의 내용이 담겨져 있는 Label
    private let quizLabel = UILabel()
    // 배경으로 넣을 ImageView
    private let backImgView = UIImageView(image: UIImage(named: "memoSpring"))
    // 정답이 쓰여있는 버튼
    private var answerButtons: [UIButton] = []
    // 오답 화면
    private var quizWrongView: QuizWrongView?
    // 종료 화면
    private var quizCompleteView: QuizCompleteView?
    // 설명 화면
    private var quizExplanationView: QuizExplanationView?
    
    required init(animalName: String, quiz: Quiz) {
        self.animalName = animalName
        self.quiz = quiz
        self.buttonCount = quiz.answers.count
        self.totalQuizCount = QuizDao().getQuizzessByName(animalName: animalName).quizzes.count
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawBackgroundImage()
        drawIndicateLable()
        drawCharacterImage()
        drawQuiz()
        drawButton()
    }
    
    // 맨 위 버튼에 그려지는 이미지 그리기
    func drawCharacterImage() {
        let characterImage = UIImageView(image: UIImage(named: "detectiveImage1"))
        self.view.addSubview(characterImage)
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        characterImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        characterImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        characterImage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(-(60 * buttonCount)+20)).isActive = true
    }
    
    // backImgView을 그리는 기능
    func drawBackgroundImage() {
        self.view.addSubview(backImgView)
        backImgView.translatesAutoresizingMaskIntoConstraints = false
        backImgView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        backImgView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        self.view.backgroundColor = .appColor(.memoWhite)
    }
    
    // quizLabel을 그리는 기능
    func drawIndicateLable() {
        self.view.addSubview(quizIndicatorLabel)
        quizIndicatorLabel.translatesAutoresizingMaskIntoConstraints = false
        quizIndicatorLabel.text = "\((index ?? 0)+1)/\(totalQuizCount)"
        quizIndicatorLabel.font = UIFont(name: "KOTRA HOPE", size: .ten*2.0)
        quizIndicatorLabel.textColor = .black
        quizIndicatorLabel.topAnchor.constraint(equalTo: backImgView.bottomAnchor).isActive = true
        quizIndicatorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 20).isActive = true
        quizIndicatorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        quizIndicatorLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        quizIndicatorLabel.adjustsFontSizeToFitWidth = true
    }
    
    // quizLabel을 그리는 기능
    func drawQuiz() {
        self.view.addSubview(quizLabel)
        let attributedString = NSMutableAttributedString.init(string: "\(quiz?.question ?? "Error: No Quiz")")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.appColor(.memoWhite), range: NSRange.init(location: 0, length: attributedString.length))
        quizLabel.attributedText = attributedString
        quizLabel.font = UIFont(name: "KOTRA HOPE", size: .ten*2.4)
        quizLabel.translatesAutoresizingMaskIntoConstraints = false
        quizLabel.topAnchor.constraint(equalTo: self.quizIndicatorLabel.bottomAnchor, constant: 10).isActive = true
        quizLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        quizLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        quizLabel.numberOfLines = 0
        
    }
    
    // 퀴즈 버튼 그리기
    func drawButton() {
        
        for _ in 0...(buttonCount-1) {
            let answerButton = UIButton()
            answerButtons.append(answerButton)
        }
        
        for i in (0...(buttonCount - 1)).reversed() {
            self.view.addSubview(answerButtons[i])
            answerButtons[i].translatesAutoresizingMaskIntoConstraints = false
            answerButtons[i].custom("\(quizAnswers[i])", titleColor: .white, size: .ten*2.4, backColor: .appColor(.primaryBrown))
            answerButtons[i].centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            if i==(buttonCount - 1) {
                answerButtons[i].bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            } else {
                answerButtons[i].bottomAnchor.constraint(equalTo: answerButtons[i+1].topAnchor, constant: -10).isActive = true
            }
            answerButtons[i].heightAnchor.constraint(equalToConstant: 50).isActive = true
            answerButtons[i].widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
            
            updateButtonFunction()
        }
    }
    
    // 버튼 내용 pageIndex에 맞춰 변경
    func updateButtonFunction() {
        for i in 0...(buttonCount-1) {
            answerButtons[i].setTitle("\(quizAnswers[i])", for: .normal)
            if i != quiz?.rightAnswerIndex {
                answerButtons[i].addTarget(self, action: #selector(addWrongView), for: .touchUpInside)
            } else {
                if index == totalQuizCount - 1 {
                    answerButtons[i].addTarget(self, action: #selector(addCompleteView), for: .touchUpInside)
                } else {
                    answerButtons[i].addTarget(self, action: #selector(sendNextPageNoti), for: .touchUpInside)
                }
            }
        }
    }
    
    @objc func sendNextPageNoti() {
        NotificationCenter.default.post(name: Notification.Name("nextPage"), object: nil)
    }
    
    // quizCompleteView 닫기
    @objc func closeCompleteView() {
        quizCompleteView!.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
    // quizCompleteView 띄우기
    @objc func addCompleteView() {
        AVPlay.shared2.playSound2(sound: "cheerSound2")
        quizCompleteView = QuizCompleteView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), animalName: animalName ?? "panda")
        quizCompleteView!.completeButton.addTarget(self, action: #selector(closeCompleteView), for: .touchUpInside)
        view.addSubview(quizCompleteView!)
        
        // 이전 문제를 다시 푼 것이라면, UserDefaults에 저장하지않도록.
        let openIndex = UserDefaults.standard.integer(forKey: "clear")
        let nowAnimalIndex = QuizDao().getAnimalDict()[animalName ?? ""] ?? 0
        if openIndex == nowAnimalIndex {
            UserDefaults.standard.set(QuizDao().getAnimalDict()[animalName!]! + 1, forKey: "clear")
        }
    }
    
    // quizWrongView 닫기
    @objc func closeWrongView() {
        quizWrongView!.removeFromSuperview()
    }
    
    // quizWrongView 띄우기
    @objc func addWrongView() {
        AVPlay.shared2.playSound2(sound: "failSound")
        quizWrongView = QuizWrongView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        quizWrongView!.completeButton.addTarget(self, action: #selector(closeWrongView), for: .touchUpInside)
        view.addSubview(quizWrongView!)
    }
    
    @objc func closeExplanationView() {
        quizExplanationView!.removeFromSuperview()
    }
    
    // quizExplanationView 닫기
    @objc func addExplanationView() {
        quizExplanationView = QuizExplanationView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        quizExplanationView!.completeButton.addTarget(self, action: #selector(closeExplanationView), for: .touchUpInside)
        view.addSubview(quizExplanationView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

