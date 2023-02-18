import SwiftUI
import AVFoundation

class ViewController: UIViewController {
    let progressBar: UIProgressView = {
        $0.progress = 0.5
        $0.progressTintColor = #colorLiteral(red: 1, green: 0.8288107514, blue: 0, alpha: 1)
        $0.trackTintColor = .darkGray
        return $0
    }(UIProgressView())
    
    let titleLabel: UILabel = {
        $0.text = "How do you like your eggs?"
        $0.textColor = .darkGray
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 30)
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer: Timer?
    var player: AVAudioPlayer!
    var totalTime = 60
    var secondsPassed = 0
 
    @objc func hardnessSelected(_ sender: UIButton) {
        timer?.invalidate()
        guard let hardness = sender.currentTitle else { return }
        totalTime = eggTimes[hardness] ?? 0
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
        } else {
            timer?.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ViewController {
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.7960784314, green: 0.9490196078, blue: 0.9882352941, alpha: 1)
        let eggStack = UIStackView()
        eggStack.axis = .horizontal
        eggStack.alignment = .fill
        eggStack.distribution = .fillEqually
        eggStack.spacing = 10
        
        ["Soft", "Medium", "Hard"].forEach {
            let button = UIButton(type: .system)
            button.setTitle($0, for: .normal)
            eggStack.addArrangedSubview(button)
            button.setBackgroundImage(UIImage(named: $0), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
            button.addTarget(self, action: #selector(hardnessSelected), for: .touchUpInside)
            button.layoutIfNeeded()
            button.subviews.first?.contentMode = .scaleAspectFit
        }
        
        let progressView = UIView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressView.addSubview(progressBar)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, eggStack, progressView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            stack.topAnchor.constraint(equalTo: margin.topAnchor),
            stack.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
            
            progressBar.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: progressView.trailingAnchor),
            progressBar.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 5)
        ])
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

