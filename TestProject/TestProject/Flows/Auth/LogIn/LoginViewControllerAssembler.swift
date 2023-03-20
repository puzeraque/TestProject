import UIKit

enum LoginViewControllerAssembler {
    static func assembly() -> LoginViewController {
        let viewModel = LoginViewModel()
        let controller = LoginViewController(viewModel: viewModel)

        viewModel.view = controller

        return controller
    }
}
