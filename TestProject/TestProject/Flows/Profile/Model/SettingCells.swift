import UIKit

enum SettingsCellType {
    case detailsTitle
    case segue
    case action
}

enum SettingType: CaseIterable {
    case tradeStore
    case paymentMethod
    case balance
    case tradeHistory
    case restorePurchase
    case help
    case logOut
}

extension SettingType {
    var cellType: SettingsCellType {
        switch self {
        case .tradeStore, .paymentMethod, .tradeHistory, .restorePurchase:
            return .segue
        case .balance:
            return .detailsTitle
        case .help, .logOut:
            return .action
        }
    }

    var title: String {
        switch self {
        case .tradeStore:
            return "Trade store"
        case .paymentMethod:
            return "Payment method"
        case .balance:
            return "Balance"
        case .tradeHistory:
            return "Trade history"
        case .restorePurchase:
            return "Restore purchase"
        case .help:
            return "Help"
        case .logOut:
            return "Log out"
        }
    }

    var icon: UIImage? {
        switch self {
        case .tradeStore, .paymentMethod, .balance, .tradeHistory:
            return Image.Profile.card.image
        case .restorePurchase:
            return Image.Profile.repeat.image
        case .help:
            return Image.Profile.help.image
        case .logOut:
            return Image.Profile.logout.image
        }
    }
}

