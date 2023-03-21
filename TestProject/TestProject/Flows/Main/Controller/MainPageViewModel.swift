import UIKit

protocol MainPageViewModelInterface {
    func handle(_ action: MainPageViewModel.Action)
}

final class MainPageViewModel {

    var view: MainPageViewControllerInterface?

    private var timer = Timer()

    private let requestManager: RequestsProtocol

    init(requestManager: RequestsProtocol) {
        self.requestManager = requestManager
    }

    private let categories = CategoriesType.allCases
    private var latesProducts = [ProductCollectionViewCell.Model]()
    private var flashSaleProducts = [ProductCollectionViewCell.Model]()

    private let dispatchGroup = DispatchGroup()

    private func updateLatest() {
        requestManager.latest { latest in
            let models = latest.latestProducts.compactMap { latestProduct -> ProductCollectionViewCell.Model? in
                guard
                    let url = URL(string: "\(latestProduct.imageUrl)"),
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data)
                else { return nil }

                return .init(
                    title: latestProduct.name,
                    productType: latestProduct.category,
                    sale: nil,
                    cost: "$ \(latestProduct.price)",
                    image: image,
                    isSale: false
                )
            }
            self.dispatchGroup.leave()
            self.latesProducts = models
        }
    }

    private func updateFlashSate() {
        requestManager.flashSale { flashSale in
            let models = flashSale.flashSaleProducts.compactMap { flashSaleProduct -> ProductCollectionViewCell.Model? in
                guard
                    let url = URL(string: "\(flashSaleProduct.imageUrl)"),
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data)
                else { return nil }

                return .init(
                    title: flashSaleProduct.name,
                    productType: flashSaleProduct.category,
                    sale: flashSaleProduct.discount,
                    cost: "$ \(flashSaleProduct.price)",
                    image: image,
                    isSale: true
                )
            }
            self.dispatchGroup.leave()
            self.flashSaleProducts = models
        }
    }

    func refresh() {
        dispatchGroup.enter()
        updateLatest()

        dispatchGroup.enter()
        updateFlashSate()

        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.view?.handle(.flashSales(self.flashSaleProducts))
            self.view?.handle(.latest(self.latesProducts))
        }
    }

    private func searchTimer(searchText: String) {
        timer.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: false,
            block: { [weak self] timer in
                guard let self = self else { return }
                self.search(with: searchText)
                timer.invalidate()
            }
        )
    }

    private func search(with text: String) {
        requestManager.searchPrompt { [weak self] searchPrompt in
            let words = searchPrompt.words.filter {
                return $0.lowercased().contains(text.lowercased())
            }
            self?.view?.handle(.search(SearchPrompt(words: words)))
        }
    }
}

extension MainPageViewModel: MainPageViewModelInterface {
    enum Action {
        case updateScreen
        case search(String)
    }

    func handle(_ action: Action) {
        switch action {
        case .updateScreen:
            view?.handle(.categories(categories))
            view?.handle(.flashSales([]))
            view?.handle(.latest([]))
            refresh()
            guard let profileInfo = ProfileStorage.profileInfo else { return }
            view?.handle(
                .profileImage(
                    ImageService.shared.getSavedImage(named: profileInfo.email)
                )
            )
        case .search(let searchText):
            searchTimer(searchText: searchText)
        }
    }
}
