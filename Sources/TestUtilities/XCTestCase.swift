import UIKit
import XCTest

extension XCTestCase {
    func findChild<T: UIView>(of uiView: UIView,
                              withIdentifier accessibilityIdentifier: String) throws -> T {
        let casted = uiView
            .findChild(withIdentifier: accessibilityIdentifier) as? T
        return try XCTUnwrap(casted)
    }

    func wait(for predicate: @autoclosure @escaping () -> Bool, timeout: TimeInterval) {
        let exp = expectation(for: .init { _,_ in
            predicate()
        }, evaluatedWith: nil, handler: nil)
        wait(for: [exp], timeout: timeout)
    }
}

fileprivate extension UIView {
    func findChild(withIdentifier accessibilityIdentifier: String) -> UIView? {
        if let child = subviews
            .first(where: { $0.accessibilityIdentifier == accessibilityIdentifier }) {
            return child
        }
        // Recurse to find a matching child in each subview!
        return subviews.lazy.compactMap {
            $0.findChild(withIdentifier: accessibilityIdentifier)
        }.first
    }
}
