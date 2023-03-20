import UIKit

enum AlertType {
    case error(title: String)
    case base(title: String)
}

final class AlertService {

    private var previousAlert: Alert?

    static let center = AlertService()

    func show(_ config: AlertType) {
        guard let previousAlert = previousAlert else {
            showAlert(config)
            return
        }
        previousAlert.fadeOut(duration: 0.3, then: { [weak self] in
            previousAlert.removeFromSuperview()
            self?.showAlert(config)
        })
    }

    private func showAlert(
        _ config: AlertType
    ) {

        guard
            let rootView = UIApplication.shared.windows.first(
                where: { $0.isKeyWindow }
            )
        else { return }

        func placeSnack(_ snack: Alert) {
            rootView.addSubview(snack)
            snack.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalToSuperview()
            }
        }

        let snack = Alert()
        snack.configure(with: config)
        placeSnack(snack)
        snack.fadeIn(duration: 0.3)
        previousAlert = snack

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            snack.fadeOut(duration: 0.3, then: {
                snack.removeFromSuperview()
            })
        }
    }
}
