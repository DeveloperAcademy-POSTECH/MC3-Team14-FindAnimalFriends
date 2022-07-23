//
//  ClearTestViewController.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/23.
//

import UIKit

class ClearTestViewController: UIViewController {
    
    var contentIndex: Int?
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("\(contentIndex ?? 7)번째 Clear", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(clearButton)
        
        clearButton.addTarget(self, action: #selector(tapClear), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        clearButton.frame = view.bounds
    }
    
    @objc func tapClear() {
        guard let index = contentIndex else { return }
        UserDefaults.standard.set(index, forKey: "Clear")
    }
    
}
