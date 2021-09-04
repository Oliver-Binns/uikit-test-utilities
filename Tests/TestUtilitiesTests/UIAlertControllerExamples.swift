import XCTest
@testable import TestUtilities

final class ParentViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "Turn the background blue",
                                  message: nil,
                                  preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.view.backgroundColor = .blue
        })
        present(alert, animated: animated)
    }
}

final class UIAlertControllerExamples: XCTestCase {

    var sut: ParentViewController!

    override func setUp() {
        super.setUp()

        sut = .init()

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = sut
        window.makeKeyAndVisible()

        sut.viewDidAppear(false)
    }

    func testCancelActionKeepsBackgroundWhite() throws {
        guard let alert = sut.presentedViewController as? UIAlertController else {
            XCTFail("Expected alert to be presented")
            return
        }
        try alert.tapAction(labelled: "Cancel")

        XCTAssertEqual(sut.view.backgroundColor, nil)
    }

    func testOKActionKeepsBackgroundWhite() throws {
        guard let alert = sut.presentedViewController as? UIAlertController else {
            XCTFail("Expected alert to be presented")
            return
        }
        try alert.tapAction(labelled: "OK")

        wait(for: self.sut.view.backgroundColor == .blue, timeout: 20)
    }
}
