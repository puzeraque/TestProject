import Foundation

import Foundation
struct LatestResponse: Codable {
    let latest: [LatestProductResponse]

//    enum CodingKeys: String, CodingKey {
//        case latest = "latest"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        latest = try values.decode([LatestProduct].self, forKey: .latest)
//    }
}

struct LatestProductResponse: Codable {
    let category: String
    let name: String
    let price: Int
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case category = "category"
        case name = "name"
        case price = "price"
        case imageUrl = "image_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decode(String.self, forKey: .category)
        name = try values.decode(String.self, forKey: .name)
        price = try values.decode(Int.self, forKey: .price)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
    }

}
