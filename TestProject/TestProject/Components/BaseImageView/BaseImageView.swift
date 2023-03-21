import UIKit

class BaseImageView: UIImageView {

    private var onTapped: VoidHandler?

    override init(image: UIImage? = nil) {
        super.init(image: image)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        isUserInteractionEnabled = true
    }

    @objc private func tapped() {
        onTapped?()
    }

    func onTap(_ completion: @escaping VoidHandler) {
        self.onTapped = completion
    }
}
