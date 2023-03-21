struct Latest {
    let latestProducts: [LatestProduct]
}

struct LatestProduct {
    let category: String
    let name: String
    let price: Int
    let imageUrl: String

    init(response: LatestProductResponse) {
        self.category = response.category
        self.name = response.name
        self.price = response.price
        self.imageUrl = response.imageUrl
    }
}

