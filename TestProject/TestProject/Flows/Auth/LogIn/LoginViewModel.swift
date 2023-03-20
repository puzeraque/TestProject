import UIKit

protocol LoginViewModelInterface {
    func handle(_ action: LoginViewModel.Action)
}

final class LoginViewModel {

    var view: LoginViewControllerInterface?
}

extension LoginViewModel: LoginViewModelInterface {
    enum Action {
        case login(String?)
    }

    func handle(_ action: Action) {
        switch action {
        case .login(let email):
            guard let email = email, email.isValidEmail else {
                view?.handle(.error(.emailDoestMatch))
                return
            }
            guard let profileModel = ProfileStorage.profileInfo else {
                view?.handle(.error(.accountDoestExist))
                return
            }
            guard profileModel.email == email else {
                view?.handle(.error(.emailDoestMatch))
                return
            }
            view?.handle(.success)
        }
    }
}
