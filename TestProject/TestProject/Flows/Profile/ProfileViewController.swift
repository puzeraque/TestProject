import UIKit
import PhotosUI

protocol ProfileViewControllerInterface {
    func handle(_ action: ProfileViewController.Action)
}

final class ProfileViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.register(
            ProfileSegueViewCell.self,
            forCellReuseIdentifier: ProfileSegueViewCell.id
        )
        tableView.register(
            ProfileSelectionViewCell.self,
            forCellReuseIdentifier: ProfileSelectionViewCell.id
        )
        tableView.register(
            ProfileDetailsViewCell.self,
            forCellReuseIdentifier: ProfileDetailsViewCell.id
        )
        tableView.showsVerticalScrollIndicator = false
        tableView.isEditing = false
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = .zero
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private let profileInfoView = ProfileMainInfoView()

    var onLogoutTapped: VoidHandler?

    private let viewModel: ProfileViewModelInterface

    init(viewModel: ProfileViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor(Color.Background.main)
        view.addAndEdges(tableView)

        profileInfoView.onIconTapped = { [weak self] in
            self?.presentImagePicker()
        }
    }

    func presentImagePicker() {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.selectionLimit = 1
        config.filter = .images
        config.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        DispatchQueue.main.async {
            self.present(picker, animated: true, completion: nil)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return SettingType.allCases.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let type = SettingType.allCases[indexPath.row]
        switch type.cellType {
        case .detailsTitle:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ProfileDetailsViewCell.id
                ) as? ProfileDetailsViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.configure(with: type)
            cell.onTap {
                AlertService.center.show(.base(title: type.title))
            }
            return cell
        case .segue:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ProfileSegueViewCell.id
                ) as? ProfileSegueViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.configure(with: type)
            cell.onTap {
                AlertService.center.show(.base(title: type.title))
            }
            return cell
        case .action:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ProfileSelectionViewCell.id
                ) as? ProfileSelectionViewCell
            else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.configure(with: type)

            cell.onTap { [weak self] in
                guard type == .logOut else {
                    AlertService.center.show(.base(title: type.title))
                    return }
                self?.onLogoutTapped?()
            }
            return cell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return profileInfoView
    }
}

extension ProfileViewController: ProfileViewControllerInterface {
    enum Action {
        case updateUserInfo(ProfileMainInfoView.Model)
    }

    func handle(_ action: Action) {
        switch action {
        case .updateUserInfo(let model):
            profileInfoView.configure(with: model)
        }
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {
        dismiss(animated: true, completion: nil)
        guard !results.isEmpty else { return }
        // request image urls
        let identifier = results.compactMap(\.assetIdentifier)
        let fetchResult = PHAsset.fetchAssets(
            withLocalIdentifiers: identifier,
            options: nil
        )
        fetchResult.enumerateObjects { (asset, index, stop) in
            PHAsset.getURL(ofPhotoWith: asset) { [weak self] (url) in
                guard
                    let url = url,
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data)
                else { return }
                self?.viewModel.handle(.saveImage(image))
                self?.tableView.reloadData()
            }
        }
    }
}
