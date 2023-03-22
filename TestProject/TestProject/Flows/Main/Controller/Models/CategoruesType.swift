import UIKit

enum CategoriesType : CaseIterable {
    case phone
    case headphones
    case games
    case cars
    case furniture
    case kids

    var image: UIImage? {
        switch self {
        case .phone:
            return Image.SearchCategories.phone.image
        case .headphones:
            return Image.SearchCategories.headphones.image
        case .games:
            return Image.SearchCategories.games.image
        case .cars:
            return Image.SearchCategories.car.image
        case .furniture:
            return Image.SearchCategories.furniture.image
        case .kids:
            return Image.SearchCategories.kid.image
        }
    }

    var title: String? {
        switch self {
        case .phone:
            return "Phone"
        case .headphones:
            return "Headphone"
        case .games:
            return "Games"
        case .cars:
            return "Cars"
        case .furniture:
            return "Home"
        case .kids:
            return "Kids"
        }
    }
}
