import UIKit

class ViewController2: UIViewController {
    
    var totalElapsed: TimeInterval = 0
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        label.text = "00:00:00"
        return label
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Refresh", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(refreshTime), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(timeLabel)
        view.addSubview(refreshButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
        ])
        
        updateTimeLabel() // Ensure time label is updated initially
    }
    
    func updateTimeLabel() {
        timeLabel.text = formattedString(for: totalElapsed)
    }
    
    func formattedString(for timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: timeInterval) ?? "00:00:00"
    }
    
    @objc func refreshTime() {
        updateTimeLabel() // Update time label when refresh button is tapped
    }
}
