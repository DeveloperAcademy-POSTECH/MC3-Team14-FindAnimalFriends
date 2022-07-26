//
//  ClearTestViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/23.
//

import UIKit

class ClearTestViewController: UIViewController {
    
    var animal: String?
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: CGPoint(x: 100, y: 200), size: CGSize(width: 200, height: 100)))
        button.setTitle("\(animal ?? "") Clear", for: .normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(clearButton)
        
        clearButton.addTarget(self, action: #selector(tapClear), for: .touchUpInside)
        
    }
    
    @objc func tapClear() {
        guard let index = QuizDao().getAnimalDict()[animal ?? "tiger"] else { return }
        UserDefaults.standard.set(index + 1, forKey: "clear")
        //currentIndex == index였지만, 클리어함으로써 새로 조명이 켜질 currentIndex는 index + 1이 된다.
        navigationController?.popViewController(animated: true)
    }
    
}
