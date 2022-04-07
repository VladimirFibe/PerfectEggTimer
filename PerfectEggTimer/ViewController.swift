//
//  ViewController.swift
//  PerfectEggTimer
//
//  Created by Vladimir Fibe on 11.02.2022.
//

import SwiftUI
import AVFoundation

class ViewController: UIViewController {
  var counter = 60
  var timer: Timer?
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "How do you like your eggs?"
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  let softButton = UIButton(type: .system)
  let mediumButton  = UIButton(type: .system)
  let hardButton = UIButton(type: .system)
  var player: AVAudioPlayer!

  func playSound() {
      guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }
    player = try! AVAudioPlayer(contentsOf: url)
    player.play()
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  func setupUI() {
    view.backgroundColor = #colorLiteral(red: 0.7960784314, green: 0.9490196078, blue: 0.9882352941, alpha: 1) // CBF2FC
    let eggs = [softButton, mediumButton, hardButton]
    let titles = ["soft", "medium", "hard"]
    for index in eggs.indices {
      let button = eggs[index]
      button.setImage(UIImage(named: titles[index])?.withRenderingMode(.alwaysOriginal), for: .normal)
      button.tag = index
      button.addTarget(self, action: #selector(hardnessSelected), for: .touchUpInside)
      button.imageView?.contentMode = .scaleAspectFit
    }
    let eggStack = UIStackView(arrangedSubviews: eggs)
    eggStack.axis = .horizontal
    eggStack.alignment = .fill
    eggStack.distribution = .fillEqually
    eggStack.spacing = 10
    let stack = UIStackView(arrangedSubviews: [titleLabel, eggStack])
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fillEqually
    view.addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
    stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    stack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive  = true
    stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  @objc func hardnessSelected(_ sender: UIButton) {
    let times = [10, 42, 72]
    guard sender.tag >= 0 && sender.tag < times.count  else { return }
    counter = times[sender.tag]
    if timer != nil {
      timer?.invalidate()
    }
    timer = Timer.scheduledTimer(timeInterval: 1,
                                 target: self,
                                 selector: #selector(updateCounter),
                                 userInfo: nil,
                                 repeats: true)
  }
  @objc func updateCounter() {
    if counter > 0 {
      counter -= 1
      titleLabel.text = "\(counter) seconds"
    } else {
      timer?.invalidate()
      titleLabel.text = "Ready"
      playSound()
    }
  }
}

struct SwiftUIController: UIViewControllerRepresentable {
  typealias UIViewControllerType = ViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
  }
}

struct SwiftUIController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIController()
      .edgesIgnoringSafeArea(.all)
  }
}

