import UIKit

final class MainFlowCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController
    private let window: UIWindow

    init(
        window: UIWindow,
        navigationController: UINavigationController
    ) {
        self.window = window
        self.navigationController = navigationController

        self.window.rootViewController = self.navigationController
    }

    override func start() {
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }

        let coordinator = SignInCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
