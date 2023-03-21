import Foundation

struct FlashSaleResponse: Codable {
    let flashSale: [FlashSaleProductResponse]

    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flashSale = try values.decode(
            [FlashSaleProductResponse].self,
            forKey: .flashSale
        )
    }

}

struct FlashSaleProductResponse: Codable {
    let category: String
    let name: String
    let price: Double
    let discount: Int
    let imageUrl: String

    enum CodingKeys: String, CodingKey {

        case category = "category"
        case name = "name"
        case price = "price"
        case discount = "discount"
        case imageUrl = "image_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decode(String.self, forKey: .category)
        name = try values.decode(String.self, forKey: .name)
        price = try values.decode(Double.self, forKey: .price)
        discount = try values.decode(Int.self, forKey: .discount)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
    }

}
