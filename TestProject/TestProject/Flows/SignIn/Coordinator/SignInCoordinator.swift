import UIKit

final class SignInCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let controller = SignInViewControllerAssembler.assembly()

        navigationController.pushViewController(controller, animated: true)
    }
}
