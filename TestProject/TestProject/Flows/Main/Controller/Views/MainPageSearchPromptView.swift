import UIKit

final class MainPageSearchPromptView: BaseView {
    private lazy var searchTextFieldContainer: BaseTextFieldContainer = {
        $0.height(32)
        $0.setupSearchView()
        return $0
    }(BaseTextFieldContainer(placeholder: "What are you looking for?"))

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.register(
            SearchTableViewCell.self,
            forCellReuseIdentifier: SearchTableViewCell.id
        )
        tableView.contentInset.top = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.isEditing = false
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = .zero
        tableView.sectionHeaderHeight = .zero
        tableView.sectionHeaderTopPadding = .zero
        tableView.tableHeaderView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private let searchCancelButton: BaseButton = {
        $0.imageView?.tintColor = Color.Content.secondary
        $0.size(.square(16))
        $0.setImage(Image.Main.clear.image, for: .normal)
        return $0
    }(BaseButton())

    private var model = [String]()

    var onTextChanged: StringHandler?

    override func setup() {
        backgroundColor(Color.Background.main)
        let searchContainer = BaseView()
        searchContainer.addAndEdgesViewWithInsets(searchTextFieldContainer, hInset: 30)
        let stackView = StackView(
            axis: .vertical,
            spacing: 10,
            arrangedSubviews: [
                searchContainer,
                tableView
            ]
        )

        addAndEdges(stackView)

        searchTextFieldContainer.onTextChanged = { [weak self] text in
            guard text.trimmingCharacters(in: .whitespacesAndNewlines).isNotEmpty else {
                self?.model = []
                self?.tableView.reloadData()
                return
            }
            self?.onTextChanged?(text.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }

    func updateData(model: [String]) {
        self.model = model
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func searchStarted() {
        searchTextFieldContainer.textField.becomeFirstResponder()
        searchTextFieldContainer.setupRightView(searchCancelButton)

        searchCancelButton.onTap { [weak self] in
            self?.fadeOut(then: {
                self?.searchTextFieldContainer.textField.resignFirstResponder()
                self?.searchTextFieldContainer.textField.text = nil
                self?.searchTextFieldContainer.setupRightView(nil)
            })
        }
    }
}

extension MainPageSearchPromptView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchTableViewCell.id,
                for: indexPath
            ) as? SearchTableViewCell
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(
            with: .init(
                title: model[indexPath.row],
                searchText: searchTextFieldContainer.text.orEmpty
            )
        )
        return cell
    }
}
