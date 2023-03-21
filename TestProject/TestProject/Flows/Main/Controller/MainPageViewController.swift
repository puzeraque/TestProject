import UIKit

fileprivate enum Constant {
    static let bottomViewHeight: CGFloat = 60
}

protocol MainPageViewControllerInterface {
    func handle(_ action: MainPageViewController.Action)
}

final class MainPageViewController: UIViewController {

    private let navigationBar = MainPageNavigationBar()
    private let searchTextFieldContainer: BaseTextFieldContainer = {
        $0.height(32)
        $0.setupSearchView()
        $0.textField.autocapitalizationType = .sentences
        return $0
    }(BaseTextFieldContainer(placeholder: "What are you looking for?"))
    private let searchContainer = BaseView()
    private let searchTextFieldButton = BaseButton()
    private let mainPageSearchPromptView = MainPageSearchPromptView()

    private lazy var categoriesLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        return layout
    }()
    private let productsLayout = LatestLayout()
    private let flashSaleLayout = FlashSaleLayout()

    private lazy var categoriesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: categoriesLayout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    private let latestCollectionHeader = ProductsHeaderView()
    private lazy var latestCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: productsLayout)
        return collectionView
    }()
    private let flashSaleCollectionHeader = ProductsHeaderView()
    private lazy var flashSaleCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flashSaleLayout)
        return collectionView
    }()
    private let brandsCollectionHeader = ProductsHeaderView()
    private lazy var brandsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: productsLayout)
        return collectionView
    }()
    private lazy var mainContainerStackView = StackView(
        axis: .vertical,
        spacing: 10,
        arrangedSubviews: [
            searchContainer,
            categoriesCollectionView,
            latestCollectionHeader,
            latestCollectionView,
            flashSaleCollectionHeader,
            flashSaleCollectionView,
            brandsCollectionHeader,
            brandsCollectionView
        ]
    )
    private let scrollView = UIScrollView()

    private lazy var categoriesMainPageDataSource = CategoriesMainPageDataSource(
        collectionView: categoriesCollectionView
    )
    private lazy var latestMainPageDataSource = LatestMainPageDataSource(
        collectionView: latestCollectionView
    )
    private lazy var flashSaleMainPageDataSource = FlashSaleMainPageDataSource(
        collectionView: flashSaleCollectionView
    )
    private lazy var brandMainPageDataSource = LatestMainPageDataSource(
        collectionView: brandsCollectionView
    )

    var onProductSelected: VoidHandler?
    var onProfileTapped: VoidHandler?

    private let viewModel: MainPageViewModelInterface

    init(viewModel: MainPageViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.handle(.updateScreen)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor(Color.Background.main)

        scrollView.contentInset.bottom = Constant.bottomViewHeight + 10
        scrollView.addAndEdgesViewWithInsets(mainContainerStackView)
        mainContainerStackView.width(view.frame.width)

        searchTextFieldContainer.addAndEdges(searchTextFieldButton)
        searchTextFieldButton.onTap { [weak self] in
            self?.mainPageSearchPromptView.fadeIn(then: {
                self?.mainPageSearchPromptView.isHidden = false
            })
            self?.mainPageSearchPromptView.searchStarted()
        }
        searchContainer.addAndEdgesViewWithInsets(searchTextFieldContainer, hInset: 30)

        view.addSubviews(navigationBar, scrollView, mainPageSearchPromptView)

        configureCollections()

        navigationBar.onProfileTapped = { [weak self] in
            self?.onProfileTapped?()
        }

        mainPageSearchPromptView.isHidden = true
        mainPageSearchPromptView.onTextChanged = { [weak self] searchText in
            self?.viewModel.handle(.search(searchText))
        }
    }

    private func setupLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.leading.trailing.equalToSuperview()
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).inset(-20)
            make.leading.trailing.bottom.equalToSuperview()
        }

        mainPageSearchPromptView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
    }

    private func configureCollections() {
        categoriesCollectionView.height(60)
        latestCollectionView.height(LatestLayout.cellHeight)
        brandsCollectionView.height(LatestLayout.cellHeight)
        flashSaleCollectionView.height(FlashSaleLayout.cellHeight)

        latestCollectionHeader.configure(with: "Latest")
        flashSaleCollectionHeader.configure(with: "Flash sale")
        brandsCollectionHeader.configure(with: "Brands")
        mainContainerStackView.setCustomSpacing(.zero, after: latestCollectionHeader)
        mainContainerStackView.setCustomSpacing(.zero, after: flashSaleCollectionHeader)
        mainContainerStackView.setCustomSpacing(.zero, after: brandsCollectionHeader)

        latestMainPageDataSource.onProductSelected = { [weak self] in
            self?.onProductSelected?()
        }

        flashSaleMainPageDataSource.onProductSelected = { [weak self] in
            self?.onProductSelected?()
        }
    }
}

extension MainPageViewController: MainPageViewControllerInterface {
    enum Action {
        case categories(_ models: [CategoriesType])
        case flashSales(_ models: [ProductCollectionViewCell.Model])
        case latest(_ models: [ProductCollectionViewCell.Model])
        case search(_ models: SearchPrompt)
        case profileImage(_ image: UIImage?)
    }

    func handle(_ action: Action) {
        switch action {
        case .categories(let models):
            categoriesMainPageDataSource.update(model: models)
        case .flashSales(let models):
            DispatchQueue.main.async {
                self.flashSaleMainPageDataSource.update(model: models)
            }
        case .latest(let models):
            DispatchQueue.main.async {
                self.latestMainPageDataSource.update(model: models)
                self.brandMainPageDataSource.update(model: models)
            }
        case .search(let model):
            mainPageSearchPromptView.updateData(model: model.words)
        case .profileImage(let image):
            navigationBar.configure(with: image)
        }
    }
}
