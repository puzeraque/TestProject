import UIKit

final class BaseButton: UIButton {

    private var onTapped: VoidHandler?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }

    @objc private func tapped() {
        onTapped?()
    }

    func onTap(_ completion: @escaping VoidHandler) {
        self.onTapped = completion
    }
}
