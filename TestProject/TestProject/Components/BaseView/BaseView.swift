import UIKit

class BaseView: UIView {

    private var onTapped: VoidHandler?

    init(backgroundColor: UIColor? = nil) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tap.cancelsTouchesInView = true
        addGestureRecognizer(tap)
    }

    @objc private func tapped() {
        onTapped?()
    }

    func onTap(_ completion: @escaping VoidHandler) {
        self.onTapped = completion
    }
}
