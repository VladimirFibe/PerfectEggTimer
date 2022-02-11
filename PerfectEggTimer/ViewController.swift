//
//  ViewController.swift
//  PerfectEggTimer
//
//  Created by Vladimir Fibe on 11.02.2022.
//

import UIKit

class ViewController: UIViewController {
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "How do you like your eggs?"
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  let softButton: UIButton = {
    let button = UIButton(type: .system)
    return button
  }()
  
  let mediumButton: UIButton = {
    let button = UIButton(type: .system)
    return button
  }()
  
  let hardButton: UIButton = {
    let button = UIButton(type: .system)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  
  func setupUI() {
    view.backgroundColor = #colorLiteral(red: 0.7960784314, green: 0.9490196078, blue: 0.9882352941, alpha: 1) // CBF2FC
    let eggs = [softButton, mediumButton, hardButton]
    let titles = ["soft", "medium", "hard"]
    for index in eggs.indices {
      eggs[index].setImage(UIImage(named: titles[index])?.withRenderingMode(.alwaysOriginal), for: .normal)
      eggs[index].tag = index
      eggs[index].addTarget(self, action: #selector(hardnessSelected), for: .touchUpInside)
    }
    let eggStack = UIStackView(arrangedSubviews: eggs)
    eggStack.axis = .horizontal
    eggStack.alignment = .center
    eggStack.distribution = .fillEqually
    eggStack.spacing = 10
    let stack = UIStackView(arrangedSubviews: [titleLabel, eggStack])
    stack.axis = .vertical
    stack.alignment = .leading
    stack.distribution = .fillEqually
    view.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    stack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive  = true
    stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  @objc func hardnessSelected(_ sender: UIButton) {
    if sender.tag == 0 {
      print("Soft")
    } else if sender.tag == 1 {
      print("Medium")
    } else {
      print("Hard")
    }
    loveCalculator()
  }
  func loveCalculator() {
    let loveScore = Int.random(in: 0...100)
    if loveScore >= 80 {
      print("You love each other like Kanye loves Kanye")
    } else if loveScore >= 40 {
      print("You go together like Coke and Mentos")
    } else {
      print("You'll be forever alone")
    }
  }
}

