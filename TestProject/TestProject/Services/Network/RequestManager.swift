import Foundation

protocol RequestManagerProtocol {
    func productDetails(completion: @escaping (ProductDetailsResponse) -> Void)
    func latest(completion: @escaping (LatestResponse) -> Void)
    func flashSale(completion: @escaping (FlashSaleResponse) -> Void)
    func searchPrompt(completion: @escaping (SearchPromptResponse) -> Void)
}

final class RequestManager: RequestManagerProtocol {
    private let parserService = ParserService()
    
    func productDetails(completion: @escaping (ProductDetailsResponse) -> Void) {
        parserService.parse(requestType: .productDetails) { model in
            guard let model = model as? ProductDetailsResponse else { return }
            completion(model)
            print(model)
        }
    }

    func latest(completion: @escaping (LatestResponse) -> Void) {
        parserService.parse(requestType: .latest) { model in
            guard let model = model as? LatestResponse else { return }
            completion(model)
            print(model)
        }
    }

    func flashSale(completion: @escaping (FlashSaleResponse) -> Void) {
        parserService.parse(requestType: .flashSale) { model in
            guard let model = model as? FlashSaleResponse else { return }
            completion(model)
            print(model)
        }
    }

    func searchPrompt(completion: @escaping (SearchPromptResponse) -> Void) {
        parserService.parse(requestType: .searchPrompt) { model in
            guard let model = model as? SearchPromptResponse else { return }
            completion(model)
            print(model)
        }
    }
}
