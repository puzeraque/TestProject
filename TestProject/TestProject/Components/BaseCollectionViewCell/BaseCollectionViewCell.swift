import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    var onTapped: VoidHandler?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor(.clear)
        contentView.backgroundColor(.clear)

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
