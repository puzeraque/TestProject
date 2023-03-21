import UIKit

class BaseTableViewCell: UITableViewCell {

    var onTapped: VoidHandler?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        contentView.backgroundColor(.clear)
        backgroundColor(.clear)

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
