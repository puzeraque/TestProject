import UIKit

final class SearchTableViewCell: BaseTableViewCell {
    private let titleLabel = Label(
        font: Fonts.h3,
        textColor: Color.Text.primary,
        textAlignment: .left
    )
    private let separatorLine = BaseView(backgroundColor: Color.TabBar.selection)

    override func setup() {
        super.setup()
        addAndEdgesViewWithInsets(titleLabel, hInset: 30, vInset: 10)

        addSubview(separatorLine)

        separatorLine.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.leading.equalToSuperview().inset(30)
        }
    }
}

extension SearchTableViewCell: Configurable {
    struct Model {
        let title: String
        let searchText: String
    }

    func configure(with model: Model) {
        titleLabel.changeColorOfPartOfTheText(
            fullText: model.title,
            partOfTheText: model.searchText
        )
    }
}
