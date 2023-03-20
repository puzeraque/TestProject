import UIKit
import SkeletonView

final class ProductDetailsImagePicker: BaseView {
    private let stackView = StackView(axis: .horizontal, spacing: 8)

    var onImageSelected: ((UIImage?) -> Void)?

    private var selectedIndex = 0

    private var imageViews = [Int: UIView]()

    override func setup() {
        super.setup()
        (0..<3).forEach { [weak self] index in
            guard let self = self else { return }
            let imageView = BaseImageView()
            imageView.cornerRadius(8)
            imageView.setSelected(self.selectedIndex == index)
            imageView.setShadow(isSelected: self.selectedIndex == index)
            imageView.isSkeletonable = true
            imageView.skeletonCornerRadius = 8
            imageView.showSkeletonWithAnimation()
            let someStack = StackView(axis: .vertical)

            someStack.addArrangedSubviews(UIView(), imageView)
            stackView.addArrangedSubview(someStack)
        }
        addAndEdges(stackView)
    }
}

extension ProductDetailsImagePicker: Configurable {
    typealias Model = [Data]

    func configure(with model: [Data]) {
        stackView.removeArrangedSubviews()
        model.enumerated().forEach { [weak self] index, data in
            guard let self = self else { return }
            let outerView = UIView()
            outerView.clipsToBounds = false
            outerView.setShadow(isSelected: self.selectedIndex == index)
            outerView.setSelected(self.selectedIndex == index)

            let imageView = BaseImageView(image: UIImage(data: data))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.cornerRadius(8)
            outerView.addAndEdges(imageView)

            let imageViewContainer = StackView(axis: .vertical)

            imageViews[index] = outerView

            imageView.onTap { [weak self] in
                guard let self = self else { return }
                self.selectedIndex = index
                self.onImageSelected?(imageView.image)
                self.imageViews.forEach { key, view in
                    view.setSelected(self.selectedIndex == key)
                    view.setShadow(isSelected: self.selectedIndex == key)
                }
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                }
            }

            imageViewContainer.addArrangedSubviews(UIView(), outerView)
            stackView.addArrangedSubview(imageViewContainer)
        }
    }
}

fileprivate extension UIView {
    func setSelected(_ isSelected: Bool) {
        size(
            CGSize(
                width: isSelected ? 110 : 86,
                height: isSelected ? 60 : 50
            )
        )
    }

    func setShadow(isSelected: Bool) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = isSelected ? UIColor.black.cgColor : UIColor.clear.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.2
    }
}
