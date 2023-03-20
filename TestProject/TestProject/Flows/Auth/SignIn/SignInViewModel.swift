import UIKit

protocol SignInViewModelInterface {
    func handle(_ action: SignInViewModel.Action)
}

final class SignInViewModel {

    var view: SignInViewControllerInterface?

}

extension SignInViewModel: SignInViewModelInterface {

    enum Action {
        case saveAccount(ProfileModel)
    }

    func handle(_ action: Action) {
        switch action {
        case .saveAccount(let model):
            guard
                model.fullName.isNotEmpty,
                model.email.isNotEmpty
            else {
                view?.handle(.error(.emptyFields))
                return
            }
            guard model.email.isValidEmail else {
                view?.handle(.error(.validationError))
                return
            }
            guard let profileInfo = ProfileStorage.profileInfo else {
                ProfileStorage.profileInfo = model
                view?.handle(.authSuccess)
                return
            }
            guard profileInfo.email != model.email else {
                view?.handle(.error(.accountExist))
                return
            }
            ProfileStorage.profileInfo = model
            view?.handle(.authSuccess)
        }
    }
}
