import UIKit
import SnapKit

extension UIView {
    func edgesSuperview() {
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func edgesSuperviewWithInsets(
        top: CGFloat = .zero,
        bottom: CGFloat = .zero,
        left: CGFloat = .zero,
        right: CGFloat = .zero
    ) {
        snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.bottom.equalToSuperview().inset(top)
            make.leading.equalToSuperview().inset(left)
            make.trailing.equalToSuperview().inset(right)
        }
    }

    func edgesSuperviewWithInset(inset: CGFloat) {
        snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(inset)
        }
    }

    func edgesSuperviewWithInsets(hInset: CGFloat = .zero, vInset: CGFloat = .zero) {
        snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(vInset)
            make.leading.trailing.equalToSuperview().inset(hInset)
        }
    }

    func addAndEdgesSuperview(_ view: UIView) {
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func addAndEdgesViewWithInsets(
        _ view: UIView,
        top: CGFloat = .zero,
        bottom: CGFloat = .zero,
        left: CGFloat = .zero,
        right: CGFloat = .zero
    ) {
        self.addSubview(view)

        view.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(top)
            make.bottom.equalToSuperview().inset(top)
            make.leading.equalToSuperview().inset(left)
            make.trailing.equalToSuperview().inset(right)
        }
    }

    func addAndEdgesViewWithInset(_ view: UIView, inset: CGFloat) {
        self.addSubview(view)

        view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(inset)
        }
    }

    func addAndEdgesViewWithInsets(_ view: UIView, hInset: CGFloat = .zero, vInset: CGFloat = .zero) {
        self.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(vInset)
            make.leading.trailing.equalToSuperview().inset(hInset)
        }
    }


    func size(_ size: CGSize) {
        snp.makeConstraints { make in
            make.size.equalTo(size)
        }
    }

    func height(_ size: CGFloat) {
        snp.makeConstraints { make in
            make.height.equalTo(size)
        }
    }

    func width(_ size: CGFloat) {
        snp.makeConstraints { make in
            make.width.equalTo(size)
        }
    }
}
