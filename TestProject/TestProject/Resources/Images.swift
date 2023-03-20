import UIKit

enum Image {
    enum Auth: String {
        case apple
        case google

        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }

    enum Main: String {
        case arrowLeft
        case chevron
        case menu
        case chevronDown
        case eyeShow
        case eyeHide
        case search
        case clear
        case profile

        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }

    enum Profile: String {
        case card
        case help
        case `repeat`
        case logout

        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }

    enum TabBar: String {
        case basket
        case heart
        case home
        case user
        case message

        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }

    enum ProductDetails: String {
        case share
        case star
        case plus
        case minus

        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }

    enum SearchCategories: String {
        case phone
        case headphones
        case games
        case furniture
        case kid
        case car

        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }
}
