import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported!")
    }
    
    // No need to implement `viewDidLoad`.
    // Instead implement `setupViews()` and `setupConstraints()`, still no harm of implementing it.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Base Customizations
        setupBaseCustomizations()
        
        // Setting up views & content (Overrideable functions)
        bind()
        DispatchQueue.main.async {
            self.setupViews()
        }
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
    
    /// Override to bind  your views and subviews.
    func bind() {}
    
    /// Override to setup your views constraints.
    func setupConstraints() {}
    
    /// Override to setup your static data to your views.
    func setupContentData() {}
    
}
