import Foundation

struct ProductDetails {
    let name: String
    let description: String
    let rating: Double
    let numberOfReviews: Int
    let price: Int
    let colors: [String]
    let imageUrls: [String]

    init(response: ProductDetailsResponse) {
        self.name = response.name
        self.description = response.description
        self.rating = response.rating
        self.numberOfReviews = response.numberOfReviews
        self.price = response.price
        self.colors = response.colors
        self.imageUrls = response.imageUrls
    }
}
