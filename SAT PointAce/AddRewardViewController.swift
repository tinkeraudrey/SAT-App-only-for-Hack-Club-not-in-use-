import UIKit

class AddRewardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = "Add Reward"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
}
