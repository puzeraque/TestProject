import UIKit
import SkeletonView

protocol ProductDetailsViewControllerInterface {
    func handle(_ action: ProductDetailsViewController.Action)
}

fileprivate enum Constant {
    static let bottomViewHeight: CGFloat = 162
}

final class ProductDetailsViewController: UIViewController {
    private let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .red
        $0.clipsToBounds = true
        $0.cornerRadius(16)
        $0.layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMaxXMaxYCorner
        ]
        return $0
    }(UIImageView())
    private let actionsView = ProductDetailsActionsView()
    private let photoPickerView = ProductDetailsImagePicker()
    private let infoStackView = StackView(axis: .vertical, spacing: 20)
    private let titleLabel = Label(
        font: Fonts.h4Bold,
        textColor: Color.Text.primary,
        textAlignment: .left
    )
    private let costLabel = Label(
        font: Fonts.titleSemiBold,
        textColor: Color.Text.primary,
        textAlignment: .right
    )
    private let subtitleLabel = Label(
        font: Fonts.h4Bold,
        textColor: Color.Text.primary,
        textAlignment: .left
    )
    private let descriptionInfoStackView = StackView(axis: .vertical, spacing: 10)
    private let descriptionLabel = Label(
        font: Fonts.caption1,
        textColor: Color.Text.secondary,
        textAlignment: .left,
        numberOfLines: .zero
    )
    private let starIconImage = BaseImageView(image: Image.ProductDetails.star.image)
    private let ratingLabel = Label(
        font: Fonts.subtitleBold,
        textColor: Color.Text.primary,
        textAlignment: .left
    )
    private let reviewsLabel = Label(
        font: Fonts.subtitleRegular,
        textColor: Color.Text.secondary,
        textAlignment: .left
    )
    private let colorLabel = Label(
        text: "Color:",
        font: Fonts.subtitleBold,
        textColor: Color.Text.secondary,
        textAlignment: .left
    )
    private let mainScrollView = {
        $0.contentInset.bottom = Constant.bottomViewHeight + 10
        return $0
    }(UIScrollView())
    private let colorPickerView = ColorPickerView()
    private let bottomView = ProductDetailsBottomView()

    private let viewModel: ProductDetailsViewModelInterface

    init(viewModel: ProductDetailsViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor(Color.Background.main)
        navigationController?.setupNavigationAppearance(backgroundColor: .clear)

        let titleStackView = StackView(axis: .horizontal)
        titleStackView.addArrangedSubviews(titleLabel, costLabel)

        descriptionInfoStackView.addArrangedSubviews(subtitleLabel, descriptionLabel)

        let descriptionInfoContainerStackView = StackView(axis: .vertical)
        descriptionInfoContainerStackView.addArrangedSubviews(descriptionInfoStackView, UIView())

        let reviewStackView = StackView(axis: .horizontal, spacing:4)
        reviewStackView.addArrangedSubviews(starIconImage, ratingLabel, reviewsLabel, UIView())
        starIconImage.size(.square(14))

        let colorPickerContainerStackView = StackView(axis: .horizontal)
        colorPickerContainerStackView.addArrangedSubviews(colorPickerView, UIView())

        let phonoPickerContainerView = BaseView()
        phonoPickerContainerView.putInCenter(photoPickerView)
        phonoPickerContainerView.height(60)
        photoPickerView.height(60)

        let imageViewStackView = StackView(axis: .horizontal)
        imageViewStackView.addArrangedSubviews(imageView, UIView())

        let containerBackView = BaseView()
        let containerStackView = StackView(axis: .vertical, spacing: 10)

        containerStackView.addArrangedSubviews(
            titleStackView,
            descriptionInfoStackView,
            reviewStackView,
            colorLabel,
            colorPickerContainerStackView
        )
        containerBackView.addAndEdgesViewWithInsets(containerStackView, hInset: 16)

        infoStackView.addArrangedSubviews(
            imageViewStackView,
            phonoPickerContainerView,
            containerBackView
        )
        infoStackView.width(view.frame.width)

        mainScrollView.addAndEdges(infoStackView)
        view.addSubviews(mainScrollView, actionsView, bottomView)

        setupLayout()

        imageView.isSkeletonable = true
        imageView.showSkeletonWithAnimation()

        photoPickerView.onImageSelected = { [weak self] image in
            self?.imageView.image = image
        }
    }

    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(view).multipliedBy(0.3)
        }

        actionsView.snp.makeConstraints { make in
            make.centerX.equalTo(imageView.snp.trailing)
            make.bottom.equalTo(imageView).offset(-30)
        }

        descriptionInfoStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
        }

        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constant.bottomViewHeight)
        }

        let navigationViewOffset = (navigationController?.navigationBar.frame.height ?? .zero) / 2
        mainScrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().inset(-navigationViewOffset)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setImages(urls: [URL?]) {
        DispatchQueue.main.async { [weak self] in
            let datas = urls.compactMap { url -> Data? in
                guard
                    let url = url,
                    let data = try? Data(contentsOf: url)
                else { return nil }
                return data
            }
            if let firstImageData = datas.first {
                self?.imageView.image = UIImage(data: firstImageData)
                self?.imageView.hideSkeleton()
            }
            self?.photoPickerView.configure(with: datas)
        }


    }
}

extension ProductDetailsViewController: ProductDetailsViewControllerInterface {
    enum Action {
        case productDetails(_ details: ProductDetails)
    }

    func handle(_ action: Action) {
        switch action {
        case .productDetails(let details):
            titleLabel.text = details.name
            subtitleLabel.text = details.name
            descriptionLabel.text = details.description
            costLabel.text = "$ \(details.price)"
            ratingLabel.text = "\(details.rating)"
            reviewsLabel.text = "(\(details.numberOfReviews) reviews)"
            setImages(urls: details.imageUrls.map { return URL(string: $0) })
            colorPickerView.configure(
                with: details.colors.map { color -> UIColor in
                    var hexString = color
                    hexString.removeFirst()
                    return UIColor(hexString)
                }
            )
            bottomView.configure(with: details.price)
        }
    }
}
