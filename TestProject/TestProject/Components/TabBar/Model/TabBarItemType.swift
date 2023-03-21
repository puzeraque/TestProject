import UIKit

enum TabBarItemType: CaseIterable {
    case home
    case favorites
    case basket
    case messages
    case profile

    var image: UIImage? {
        switch self {
        case .home:
            return Image.TabBar.home.image
        case .favorites:
            return Image.TabBar.heart.image
        case .basket:
            return Image.TabBar.basket.image
        case .messages:
            return Image.TabBar.message.image
        case .profile:
            return Image.TabBar.user.image
        }
    }
}
