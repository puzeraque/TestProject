//import UIKit
//
//public extension UINavigationController {
//    func pushViewController(_ controller: UIViewController,
//                            animated: Bool,
//                            completion: (() -> Void)?) {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        pushViewController(controller, animated: animated)
//        CATransaction.commit()
//    }
//
//    func popViewController(animated: Bool, completion: (() -> Void)?) {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        popViewController(animated: animated)
//        CATransaction.commit()
//    }
//
//    func popToRootController(animated: Bool, completion: (() -> Void)?) {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
//        popToRootViewController(animated: animated)
//        CATransaction.commit()
//    }
//}
//
//public extension UINavigationController {
//    func setupWhiteNavigationAppearance(backgroundColor: UIColor? = nil ) {
//        let backImageInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
//        let arrowImage = Asset.icArrowBack24.image.withAlignmentRectInsets(backImageInsets)
//        self.additionalSafeAreaInsets.top = 13
//
//        if #available(iOS 13, *) {
//            let appearance = UINavigationBarAppearance()
//            let backImageInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
//            let arrowImage = Asset.icArrowBack24.image.withAlignmentRectInsets(backImageInsets)
//
//            appearance.shadowColor = .clear
//
//            let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
//            appearance.titleTextAttributes = [
//                .foregroundColor: Palette.Text.primary,
//                .font: Fonts.shared.h3
//            ]
//
//            appearance.buttonAppearance = buttonAppearance
//            appearance.setBackIndicatorImage(arrowImage, transitionMaskImage: arrowImage)
//            appearance.backgroundColor = backgroundColor ?? Palette.Background.main
//            navigationBar.setBackgroundImage(UIImage(), for: .default)
//            navigationBar.shadowImage = UIImage()
//            navigationBar.standardAppearance = appearance
//            navigationBar.scrollEdgeAppearance = appearance
//            navigationBar.compactAppearance = appearance
//            self.navigationBar.tintColor(Palette.Text.primary)
//            if #available(iOS 15.0, *) {
//                navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
//            }
//        } else {
//            self.navigationBar.backIndicatorImage = arrowImage
//            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
//            self.navigationBar.barTintColor = Palette.Background.main
//            self.navigationBar.titleTextAttributes = [
//                .foregroundColor: Palette.Text.primary,
//                .font: Fonts.shared.h3
//            ]
//            self.navigationBar.tintColor(Palette.Text.primary)
//        }
//    }
//
//    func setupDefaultNavigationAppearance() {
//        if #available(iOS 13, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = Palette.Background.main
//            appearance.shadowColor = .clear
//            self.navigationBar.standardAppearance = appearance
//            self.navigationBar.scrollEdgeAppearance = appearance
//            self.navigationBar.standardAppearance = appearance
//            if #available(iOS 15.0, *) {
//                self.navigationBar.compactScrollEdgeAppearance = appearance
//            }
//        } else {
//            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
//            self.navigationBar.barTintColor = Palette.Background.main
//        }
//    }
//
//    func setupNavigationBarAppearance(backgroundColor: UIColor) {
//        let backImageInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
//        let arrowImage = Asset.icArrowBack24.image.withAlignmentRectInsets(backImageInsets)
//        self.additionalSafeAreaInsets.top = 13
//
//        if #available(iOS 13, *) {
//            let appearance = UINavigationBarAppearance()
//            let backImageInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
//            let arrowImage = Asset.icArrowBack24.image.withAlignmentRectInsets(backImageInsets)
//
//            appearance.shadowColor = .clear
//
//            let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
//            appearance.titleTextAttributes = [
//                .foregroundColor: Palette.Text.primary,
//                .font: Fonts.shared.h3
//            ]
//
//            appearance.buttonAppearance = buttonAppearance
//            appearance.setBackIndicatorImage(arrowImage, transitionMaskImage: arrowImage)
//            appearance.backgroundColor = backgroundColor
//            navigationBar.setBackgroundImage(UIImage(), for: .default)
//            navigationBar.shadowImage = UIImage()
//            navigationBar.standardAppearance = appearance
//            navigationBar.scrollEdgeAppearance = appearance
//            navigationBar.compactAppearance = appearance
//            self.navigationBar.tintColor(Palette.Text.primary)
//            if #available(iOS 15.0, *) {
//                navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
//            }
//        } else {
//            self.navigationBar.backIndicatorImage = arrowImage
//            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
//            self.navigationBar.barTintColor = backgroundColor
//            self.navigationBar.titleTextAttributes = [
//                .foregroundColor: Palette.Text.primary,
//                .font: Fonts.shared.h3
//            ]
//            self.navigationBar.tintColor(Palette.Text.primary)
//        }
//    }
//}
