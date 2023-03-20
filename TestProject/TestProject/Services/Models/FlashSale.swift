import Foundation

struct FlashSale {
    let flashSaleProducts: [FlashSaleProduct]

}

struct FlashSaleProduct {
    let category: String
    let name: String
    let price: Double
    let discount: Int
    let imageUrl: String

    init(response: FlashSaleProductResponse) {
        self.category = response.category
        self.name = response.name
        self.price = response.price
        self.discount = response.discount
        self.imageUrl = response.imageUrl
    }
}
