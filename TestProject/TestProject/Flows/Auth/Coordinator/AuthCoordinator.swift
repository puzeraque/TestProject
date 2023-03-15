import UIKit

final class AuthCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        super.start()
        presentSignIn()
    }

    private func presentSignIn() {
        let controller = SignInViewControllerAssembler.assembly()
        controller.onLoginTapped = { [weak self] in
            self?.presentLogin()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    private func presentLogin() {
        let controller = LoginViewControllerAssembler.assembly()

        navigationController.pushViewController(controller, animated: true)
    }
}
