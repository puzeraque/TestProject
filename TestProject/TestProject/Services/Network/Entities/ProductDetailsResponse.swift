import Foundation

struct ProductDetailsResponse: Codable {
    let name: String
    let description: String
    let rating: Double
    let numberOfReviews: Int
    let price: Int
    let colors: [String]
    let imageUrls: [String]

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case description = "description"
        case rating = "rating"
        case numberOfReviews = "number_of_reviews"
        case price = "price"
        case colors = "colors"
        case imageUrls = "image_urls"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        rating = try values.decode(Double.self, forKey: .rating)
        numberOfReviews = try values.decode(Int.self, forKey: .numberOfReviews)
        price = try values.decode(Int.self, forKey: .price)
        colors = try values.decode([String].self, forKey: .colors)
        imageUrls = try values.decode([String].self, forKey: .imageUrls)
    }

}
