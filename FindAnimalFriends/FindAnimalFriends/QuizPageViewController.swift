//
//  PageViewController.swift
//  BookPage
//
//  Created by Dongjin Jeon on 2022/07/22.
//

import UIKit

class QuizPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    required override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("\(self.gestureRecognizers)")
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                return nil
            } else {
                // go to previous page in array
                pageIndex -= 1
                updateButton()
                return self.pages[viewControllerIndex - 1]
            }
            
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                pageIndex += 1
                updateButton()
                return self.pages[viewControllerIndex + 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    
    var pages = [UIViewController]()
    var pageIndex = 0
    var answerButtons:[UIButton] = {
        var answerButtons:[UIButton] = []
        for i in 0...(sampleAnswer.count-1) {
            let answerButton = UIButton()
            answerButtons.append(answerButton)
        }
        return answerButtons
    }()
    
    override func viewDidLoad() {
        
        // 터치, 끌기 제스처를 통한 페이지 이동 비활성화
        for recognizer in self.gestureRecognizers {
            if recognizer is UITapGestureRecognizer {
                recognizer.isEnabled = false
            }
            else if recognizer is UIPanGestureRecognizer {
                recognizer.isEnabled = false
            }
        }
        
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        let initialPage = 0
        pageIndex = initialPage
        
        for i in 0...(sampleQuiz.count-1) {
            let page = QuizViewController()
            page.index = i
            self.pages.append(page)
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
        
        drawCharacterImage()
        drawButton()
    }
    
    func drawCharacterImage() {
        let characterImage = UIImageView(image: UIImage(named: "detectiveImage1"))
        self.view.addSubview(characterImage)
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        characterImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        characterImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        characterImage.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -220).isActive = true
    }
    
    // 버튼 그리기
    func drawButton() {
        
        for i in (0...(sampleAnswer[pageIndex].count - 1)).reversed() {
            self.view.addSubview(answerButtons[i])
            answerButtons[i].setTitle("\(sampleAnswer[pageIndex][i])", for: .normal)
            answerButtons[i].layer.borderColor = UIColor.white.cgColor
            answerButtons[i].layer.backgroundColor = UIColor.appColor(.primaryBrown).cgColor
            answerButtons[i].layer.cornerRadius = 8
            answerButtons[i].titleLabel?.font = UIFont(name: "KOTRA HOPE", size: 30)
            answerButtons[i].translatesAutoresizingMaskIntoConstraints = false
            answerButtons[i].centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            if i==(sampleAnswer[pageIndex].count - 1) {
                answerButtons[i].bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            } else {
                answerButtons[i].bottomAnchor.constraint(equalTo: answerButtons[i+1].topAnchor, constant: -10).isActive = true
            }
            answerButtons[i].heightAnchor.constraint(equalToConstant: 50).isActive = true
            answerButtons[i].widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
            answerButtons[i].addTarget(self, action: #selector(self.goToNextPage), for: .touchUpInside)
        }
    }
    
    // 버튼 내용 pageIndex에 맞춰 변경
    func updateButton() {
        for i in 0...(sampleAnswer[pageIndex].count-1) {
            answerButtons[i].setTitle("\(sampleAnswer[pageIndex][i])", for: .normal)
        }
    }
}

extension UIPageViewController {
    
    @objc func goToNextPage() {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
            }
        }
    }

    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let previousPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController){
                setViewControllers([previousPage], direction: .reverse, animated: true, completion: completion)
            }
        }
    }
}

// 퀴즈에 대한 데이터가 만들어지기 전에 사용할 퀴즈 예시 데이터
var sampleQuiz = ["Q11fjweiojfijniowfnowifnwif0wenfg0iwn0ine0pfgfjwnfonwdfionswf", "Q2", "Q3", "Q4", "Q5"]
var sampleAnswer = [["A1-1", "A1-2", "A1-3", "A1-4"], ["A2-1", "A2-2", "A2-3", "A2-4"],["A3-1", "A3-2", "A3-3", "A3-4"],["A4-1", "A4-2", "A4-3", "A4-4"],["A5-1", "A5-2", "A5-3", "A5-4"]]
