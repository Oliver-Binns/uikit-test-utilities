import UIKit

public extension UIAlertController {
    func tapAction(index: Int) {
        dismiss(animated: false) { [unowned self] in
            self.actions[index].runHandler()
        }
    }

    func tapAction(labelled title: String) throws {
        guard let actionIndex = actions.firstIndex(where: { $0.title == title }) else {
            throw UtilityError.actionNotFound
        }
        tapAction(index: actionIndex)
    }
}

fileprivate extension UIAlertAction {
    typealias AlertHandler = @convention(block) (UIAlertAction) -> Void

    // MARK: - Helper: Use Private APIs (naughty!) to trigger alert action
    // Do not use this in the main app bundle as it will result in rejection from the App Store!
    func runHandler() {
        guard let handler = value(forKey: "handler") else { return }
        unsafeBitCast(handler as AnyObject, to: AlertHandler.self)(self)
    }
}
