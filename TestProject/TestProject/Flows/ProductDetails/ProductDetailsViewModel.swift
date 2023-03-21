import Foundation

protocol ProductDetailsViewModelInterface {
    func handle(_ action: ProductDetailsViewModel.Action)
}

final class ProductDetailsViewModel {

    var view: ProductDetailsViewControllerInterface?

    private let requestManager: RequestsProtocol

    init(requestManager: RequestsProtocol) {
        self.requestManager = requestManager
    }

    private func productDetails() {
        requestManager.productDetails { [weak self] details in
            DispatchQueue.main.async {
                self?.view?.handle(.productDetails(details))
            }
        }
    }
}

extension ProductDetailsViewModel: ProductDetailsViewModelInterface {
    enum Action {
        case updateDetails
    }

    func handle(_ action: Action) {
        switch action {
        case .updateDetails:
            productDetails()
        }
    }
}
