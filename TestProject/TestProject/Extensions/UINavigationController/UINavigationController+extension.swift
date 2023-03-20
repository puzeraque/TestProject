import UIKit

public extension UINavigationController {
    func setupNavigationAppearance(backgroundColor: UIColor? = nil) {
        let backImageInsets = UIEdgeInsets(top: 7, left: 12, bottom: 0, right: 0)
        let arrowImage = Image.Main.arrowLeft.image?.withAlignmentRectInsets(backImageInsets)
        self.additionalSafeAreaInsets.top = 13

        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear

        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        appearance.titleTextAttributes = [
            .foregroundColor: Color.Text.primary,
            .font: Fonts.title
        ]
        appearance.titlePositionAdjustment = UIOffset(horizontal: .zero, vertical: -6)
        appearance.buttonAppearance = buttonAppearance
        appearance.setBackIndicatorImage(arrowImage, transitionMaskImage: arrowImage)
        appearance.backgroundColor = backgroundColor != nil ? backgroundColor : Color.Background.main
        appearance.configureWithTransparentBackground()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance

        navigationBar.tintColor = Color.Content.primary
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationItem.backButtonDisplayMode = .minimal
        edgesForExtendedLayout = []
        setNavigationBarHidden(false, animated: true)
    }
}
