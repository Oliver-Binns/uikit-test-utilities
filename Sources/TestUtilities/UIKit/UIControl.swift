import UIKit

public extension UIControl {
    func sendEvent(_ event: Event, withTarget target: UIView) {
        _ = actions(forTarget: target, forControlEvent: event)?
            .map(Selector.init(_:))
            .map(target.perform(_:))
    }
}
