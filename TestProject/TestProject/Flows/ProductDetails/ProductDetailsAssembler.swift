import UIKit

enum ProductDetailsAssembler {
    static func assembly(
        requestManager: RequestsProtocol
    ) -> ProductDetailsViewController {
        let viewModel = ProductDetailsViewModel(requestManager: requestManager)
        let controller = ProductDetailsViewController(viewModel: viewModel)
        viewModel.view = controller
        viewModel.handle(.updateDetails)
        return controller
    }
}
