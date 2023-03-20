import UIKit

enum MainPageAssembler {
    static func assembly(requestManager: RequestsProtocol) -> MainPageViewController {
        let viewModel = MainPageViewModel(requestManager: requestManager)
        let controller = MainPageViewController(viewModel: viewModel)

        viewModel.view = controller

        return controller
    }
}
