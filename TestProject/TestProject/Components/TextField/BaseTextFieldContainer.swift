import UIKit

final class BaseTextFieldContainer: UIView {

    let textField = BaseTextField()
    
    private let secureView: BaseButton = {
        $0.setImage(Image.Main.eyeShow.image, for: .normal)
        $0.imageView?.tintColor = Color.Text.secondary
        $0.size(.square(16))
        return $0
    }(BaseButton())
    private let searchImageView: BaseImageView = {
        $0.tintColor = Color.Text.secondary
        $0.size(.square(20))
        return $0
    }(BaseImageView(image: Image.Main.search.image))

    var text: String? {
        return textField.text
    }

    var onTextChanged: StringHandler?
    var onShouldReturn: VoidHandler?

    init(placeholder: String? = nil) {
        super.init(frame: .zero)
        setup()
        self.placeholder(placeholder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        cornerRadius(self.frame.height / 2)
    }

    private func setup() {
        backgroundColor = Color.Background.secondary
        addAndEdgesViewWithInsets(textField, hInset: 10)

        textField.delegate = self
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
    }

    func placeholder(_ string: String?) {
        textField.placeholder(string)
    }

    func setupRightView(_ view: UIView?) {
        textField.rightView = view
        textField.rightViewMode = .always
    }

    func setupSecureView() {
        textField.isSecureTextEntry = true
        textField.rightView = secureView
        textField.rightViewMode = .always

        secureView.onTap { [weak self] in
            guard let self = self else { return }
            self.textField.isSecureTextEntry.toggle()
            self.secureView.setImage(
                self.textField.isSecureTextEntry
                ? Image.Main.eyeShow.image
                : Image.Main.eyeHide.image,
                for: .normal
            )
        }
    }

    func setupSearchView() {
        textField.rightView = searchImageView
        textField.rightViewMode = .always
    }
}

extension BaseTextFieldContainer: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        onTextChanged?(textField.text.orEmpty)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onShouldReturn?()
        return false
    }
}
