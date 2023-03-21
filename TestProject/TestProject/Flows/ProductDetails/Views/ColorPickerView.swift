import UIKit
import SkeletonView

fileprivate enum Constant {
    static let cornerRadius: CGFloat = 12
    static let width: CGFloat = 45
    static let height: CGFloat = 35
}

final class ColorPickerView: BaseView {
    private let stackView = StackView(axis: .horizontal, spacing: 12)

    private var selectedIndex = 0

    private var views = [Int: BaseView]()

    override func setup() {
        super.setup()
        (0..<3).forEach { index in
            let baseView = BaseView()
            baseView.cornerRadius(Constant.cornerRadius)
            baseView.skeletonCornerRadius = Float(Constant.cornerRadius)
            baseView.size(
                CGSize(
                    width: Constant.width,
                    height: Constant.height
                )
            )
            baseView.isSkeletonable = true
            baseView.showSkeletonWithAnimation()
            stackView.addArrangedSubview(baseView)
        }

        addAndEdges(stackView)
    }
}

extension ColorPickerView: Configurable {
    typealias Model = [UIColor?]

    func configure(with model: [UIColor?]) {
        stackView.removeArrangedSubviews()

        model.enumerated().forEach { [weak self] index, color in
            guard let self = self else { return }
            let baseView = BaseView()
            baseView.cornerRadius(Constant.cornerRadius)
            baseView.backgroundColor = color
            baseView.size(
                CGSize(
                    width: Constant.width,
                    height: Constant.height
                )
            )
            baseView.setBorder(isSelected: self.selectedIndex == index)

            views[index] = baseView
            baseView.onTap { [weak self] in
                guard let self = self else { return }
                self.selectedIndex = index
                self.views.forEach { key, image in
                    image.setBorder(isSelected: self.selectedIndex == key)
                }
            }
            stackView.addArrangedSubview(baseView)
        }
    }
}

fileprivate extension BaseView {
    func setBorder(isSelected: Bool) {
        border(width: 4, color: isSelected ? Color.Button.main : UIColor.clear)
    }
}
