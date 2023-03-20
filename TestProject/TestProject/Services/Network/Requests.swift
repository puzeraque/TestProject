import Foundation

protocol RequestsProtocol {
    func productDetails(completion: @escaping (ProductDetails) -> Void)
    func latest(completion: @escaping (Latest) -> Void)
    func flashSale(completion: @escaping (FlashSale) -> Void)
    func searchPrompt(completion: @escaping (SearchPrompt) -> Void)
}

final class Requests: RequestsProtocol {
    private let manager: RequestManagerProtocol

    init() {
        self.manager = RequestManager()
    }

    func productDetails(completion: @escaping (ProductDetails) -> Void) {
        manager.productDetails { responseModel in
            let productDetails = ProductDetails(response: responseModel)
            completion(productDetails)
        }
    }

    func latest(completion: @escaping (Latest) -> Void) {
        manager.latest { responseModel in
            let latest = Latest(
                latestProducts: responseModel.latest.map {
                    return LatestProduct(response: $0)
                }
            )
            completion(latest)
        }
    }

    func flashSale(completion: @escaping (FlashSale) -> Void) {
        manager.flashSale { responseModel in
            let flashSale = FlashSale(
                flashSaleProducts: responseModel.flashSale.map {
                    return FlashSaleProduct(response: $0)
                }
            )
            completion(flashSale)
        }
    }

    func searchPrompt(completion: @escaping (SearchPrompt) -> Void) {
        manager.searchPrompt { responseModel in
            completion(SearchPrompt(words: responseModel.words))
        }
    }
}

