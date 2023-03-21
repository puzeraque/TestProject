import Foundation

enum RequestType {
    case productDetails
    case latest
    case flashSale
    case searchPrompt

    var url: URL? {
        return URL(string: Environment.host + endpoint)
    }

    var responseModelType: Codable.Type {
        switch self {
        case .productDetails:
            return ProductDetailsResponse.self
        case .latest:
            return LatestResponse.self
        case .flashSale:
            return FlashSaleResponse.self
        case .searchPrompt:
            return SearchPromptResponse.self
        }
    }

    private var endpoint: String {
        switch self {
        case .productDetails:
            return "f7f99d04-4971-45d5-92e0-70333383c239"
        case .latest:
            return "cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        case .flashSale:
            return "a9ceeb6e-416d-4352-bde6-2203416576ac"
        case .searchPrompt:
            return "4c9cd822-9479-4509-803d-63197e5a9e19"
        }
    }

}
