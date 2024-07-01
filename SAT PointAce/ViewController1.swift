import UIKit

class ViewController1: UIViewController {
    
    var timer = Timer()
    var startTime: Date?
    var elapsedTime: TimeInterval = 0
    var totalElapsed: TimeInterval = 0 // Total accumulated time
    var isTimerRunning = false
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        label.text = "00:00:00"
        return label
    }()
    
    lazy var startStopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(startStopTimer), for: .touchUpInside)
        return button
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(submitTimer), for: .touchUpInside)
        button.isHidden = true // Initially hidden
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(timerLabel)
        view.addSubview(startStopButton)
        view.addSubview(submitButton)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        startStopButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startStopButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: startStopButton.bottomAnchor, constant: 20),
        ])
    }
    
    @objc func startStopTimer() {
        if isTimerRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    func startTimer() {
        startTime = Date()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        isTimerRunning = true
        startStopButton.setTitle("Stop", for: .normal)
        submitButton.isHidden = true // Hide submit button while timer is running
    }
    
    func stopTimer() {
        timer.invalidate()
        isTimerRunning = false
        startStopButton.setTitle("Start", for: .normal)
        submitButton.isHidden = false // Show submit button after stopping timer
    }
    
    @objc func updateTimerLabel() {
        guard let startTime = startTime else { return }
        elapsedTime = Date().timeIntervalSince(startTime)
        let formattedTime = formattedString(for: elapsedTime)
        timerLabel.text = formattedTime
    }
    
    func formattedString(for timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: timeInterval) ?? "00:00:00"
    }
    
    @objc func submitTimer() {
        totalElapsed += elapsedTime // Accumulate total time
        
        // Pass total time to existing ViewController2 if it exists
        if let vc2 = navigationController?.viewControllers.first(where: { $0 is ViewController2 }) as? ViewController2 {
            vc2.totalElapsed = totalElapsed
            vc2.updateTimeLabel() // Update time label in ViewController2
            navigationController?.popToViewController(vc2, animated: true)
        } else {
            let vc2 = ViewController2()
            vc2.totalElapsed = totalElapsed // Pass total time to new ViewController2
            navigationController?.pushViewController(vc2, animated: true)
        }
    }
}
