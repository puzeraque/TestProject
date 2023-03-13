import UIKit

public extension UIWindow {

    static let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero

    static let safeAreaBottomInset: CGFloat = safeAreaInsets.bottom

    static let safeAreaTopInset: CGFloat = safeAreaInsets.top

    static let hasNotch: Bool = safeAreaBottomInset > 0
}
