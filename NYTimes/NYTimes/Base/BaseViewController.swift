
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Initialization
    let mainViewModel: ViewModel
    required init?(coder: NSCoder, viewModel: ViewModel) {
        self.mainViewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a viewModel.")
    }
    
    // MARK: - Lifecycle
    
    // No need to implement `viewDidLoad`.
    // Instead implement `setupViews()` and `setupConstraints()`, still no harm of implementing it.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base Customizations
        setupBaseCustomizations()
        
        // Setting up views & content (Overrideable functions)
        setupViews()
        setupConstraints()
        setupContentData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // force-close the keybaord when the viewController is disappearing
        view.endEditing(true)
    }
    
    deinit {
        print("deinit: \(classForCoder)")
    }
    
    private func setupBaseCustomizations() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Overridable functions
    /// Override to setup your views and subviews.
    func setupViews() {}
    
    /// Override to setup your views constraints.
    func setupConstraints() {}
    
    /// Override to setup your static data to your views.
    func setupContentData() {}
    
}

extension BaseViewController {
    static func create(with storyboardID: String, viewModel: ViewModel) -> Self {
        let storyboard = UIStoryboard(name: storyboardID, bundle: nil)
        return storyboard.instantiateViewController(identifier: NSStringFromClass(self).components(separatedBy: ".").last!, creator: { coder in
            return self.init(coder: coder, viewModel: viewModel)
        })
    }
}
