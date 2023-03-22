import UIKit

protocol LoginViewModelInterface {
    func handle(_ action: LoginViewModel.Action)
}

final class LoginViewModel {

    var view: LoginViewControllerInterface?
}

extension LoginViewModel: LoginViewModelInterface {
    enum Action {
        case login(LoginModel)
    }

    func handle(_ action: Action) {
        switch action {
        case .login(let model):
            guard
                model.email.isNotEmpty,
                model.password.isNotEmpty
            else {
                view?.handle(.error(.emptyFields))
                return
            }
            guard model.email.isValidEmail else {
                view?.handle(.error(.emailDoestMatch))
                return
            }
            guard let profileModel = ProfileStorage.profileInfo else {
                view?.handle(.error(.accountDoestExist))
                return
            }
            guard profileModel.email == model.email else {
                view?.handle(.error(.emailDoestMatch))
                return
            }
            view?.handle(.success)
        }
    }
}
