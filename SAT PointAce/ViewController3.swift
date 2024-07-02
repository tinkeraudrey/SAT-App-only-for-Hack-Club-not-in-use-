import UIKit

class ViewController3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        let addButton = UIButton(type: .system)
        addButton.setTitle("Add Reward", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addButton.addTarget(self, action: #selector(addRewardTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func addRewardTapped() {
        let addRewardVC = AddRewardViewController()
        navigationController?.pushViewController(addRewardVC, animated: true)
    }
}
