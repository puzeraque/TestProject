import UIKit

protocol ProfileViewModelInterface {
    func handle(_ action: ProfileViewModel.Action)
}
final class ProfileViewModel {
    var view: ProfileViewControllerInterface?
}

extension ProfileViewModel: ProfileViewModelInterface {
    enum Action {
        case saveImage(UIImage?)
        case getProfileData
    }

    func handle(_ action: Action) {
        guard let data = ProfileStorage.profileInfo else { return }
        switch action {
        case .saveImage(let image):
            _ = ImageService.shared.saveImage(image: image, path: data.email)
            let image = ImageService.shared.getSavedImage(named: data.email)

            view?.handle(
                .updateUserInfo(
                    ProfileMainInfoView.Model(
                        icon: image,
                        fullName: data.fullName
                    )
                )
            )
        case .getProfileData:
            let image = ImageService.shared.getSavedImage(named: data.email)

            view?.handle(
                .updateUserInfo(
                    ProfileMainInfoView.Model(
                        icon: image,
                        fullName: data.fullName
                    )
                )
            )
        }
    }
}
