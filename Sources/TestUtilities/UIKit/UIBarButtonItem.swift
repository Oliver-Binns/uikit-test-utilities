import UIKit

public extension UIBarButtonItem {
    func sendAction(file: StaticString = #file, line: UInt = #line) throws {
        guard let action = action else {
            throw UtilityError.actionNotFound
        }
        UIApplication.shared
            .sendAction(action, to: target, from: self, for: nil)
    }
}
