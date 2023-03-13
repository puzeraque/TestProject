import UIKit

public extension UINavigationController {
    func setupWhiteNavigationAppearance(backgroundColor: UIColor? = nil) {
//        let backImageInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        let arrowImage = UIImage(named: "arrow_left")
        self.additionalSafeAreaInsets.top = 13
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
//            let backImageInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
            let arrowImage = UIImage(named: "arrow_left")

            appearance.shadowColor = .clear

            let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
            appearance.titleTextAttributes = [
                .foregroundColor: Color.Text.primary,
                .font: Fonts.h3
            ]
            appearance.buttonAppearance = buttonAppearance
            appearance.setBackIndicatorImage(arrowImage, transitionMaskImage: arrowImage)
            appearance.backgroundColor = backgroundColor
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance

            self.navigationBar.tintColor = Color.Content.primary
            if #available(iOS 15.0, *) {
                navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
            }
        } else {
            self.navigationBar.backIndicatorImage = arrowImage
            self.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
            self.navigationBar.barTintColor = .clear
            self.navigationBar.titleTextAttributes = [
                .foregroundColor: Color.Text.primary,
                .font: Fonts.h3
            ]
            self.navigationBar.tintColor = Color.Content.primary
        }
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationItem.backButtonDisplayMode = .minimal
    }

    func removeBackButtonTitle() {
       navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "",
        style: .plain,
        target: nil,
        action: nil
       )
    }
}
