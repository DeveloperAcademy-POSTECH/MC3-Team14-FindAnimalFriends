//
//  PageViewController.swift
//  BookPage
//
//  Created by Dongjin Jeon on 2022/07/22.
//

import UIKit


// TODO: - PageView를 넘기는 기능 때문에 PageViewController에 버튼이 따로 빠져있습니다. UIPageViewController에서 다음 페이지로 넘어가는 기능을 다른 뷰에 뺄 수 있는지 알아봐야합니다.
class QuizPageViewController: UIPageViewController {
    
    // PageViewContoll에서 띄울 화면에 대한 변수
    private var pages: [UIViewController] = []
    // 대상 동물의 이름
    private var animalName: String?
    // Quiz의 데이터가 저장되어있는 변수
    private var animalQuizzes: AnimalQuizzes {
        QuizDao().getQuizzessByName(animalName: animalName ?? "panda")
    }
    
    required init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil, animalName: String) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation)
        
        NotificationCenter.default.post(name: Notification.Name("nextPage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToNextPage), name:Notification.Name("nextPage"), object: nil)
        
        self.animalName = animalName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        // 터치, 끌기 제스처를 통한 페이지 이동 비활성화
        for recognizer in self.gestureRecognizers {
            if recognizer is UITapGestureRecognizer {
                recognizer.isEnabled = false
            } else if recognizer is UIPanGestureRecognizer {
                recognizer.isEnabled = false
            }
        }
        
        super.viewDidLoad()
        
        self.dataSource = self
        
        setQuizPages()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("nextPage"), object: nil)
    }
    
    // quizPage 설정
    func setQuizPages() {
        let initialPage = 0
        
        for i in 0...(animalQuizzes.quizzes.count-1) {
            let page = QuizViewController(animalName: animalName ?? "panda", quiz: animalQuizzes.quizzes[i])
            page.index = i
            self.pages.append(page)
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
}

extension QuizPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                return nil
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
            
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                return nil
            }
        }
        return nil
    }
}

extension UIPageViewController {
    
    // 다음 페이지로 가는 기능
    @objc func goToNextPage() {
        if let currentViewController = viewControllers?[0] {
            AVPlay.shared2.playSound2(sound: "pageFlipSound")
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
            }
        }
    }
}
