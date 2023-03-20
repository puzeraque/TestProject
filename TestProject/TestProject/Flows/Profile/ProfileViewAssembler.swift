import UIKit

enum ProfileViewAssembler {
    static func assembly() -> ProfileViewController {
        let viewModel = ProfileViewModel()
        let controller = ProfileViewController(viewModel: viewModel)

        viewModel.view = controller
        viewModel.handle(.getProfileData)

        return controller
    }
}
