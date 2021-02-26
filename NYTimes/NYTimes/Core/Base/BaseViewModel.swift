import Foundation

protocol ViewModel {}

class BaseViewModel: NSObject, ViewModel {
    deinit {
        print("deinit: \(classForCoder)")
    }
}
