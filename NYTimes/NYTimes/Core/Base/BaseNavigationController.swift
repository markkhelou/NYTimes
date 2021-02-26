import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
    
    deinit {
        print("deinit: \(classForCoder)")
    }
    
    /// Setup navigationBar custom appearance
    private func setupAppearance() {
        navigationBar.barTintColor = .black
        navigationBar.tintColor = .white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
        ]
        navigationBar.isTranslucent = false
    }
}
