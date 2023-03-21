import UIKit
import SkeletonView

extension UIView {
    func showSkeletonWithAnimation() {
        self.showAnimatedGradientSkeleton(
            usingGradient: .init(
                baseColor: Color.TabBar.selection,
                secondaryColor: .white
            ),
            transition: .crossDissolve(0.2)
        )
    }
}
