import UIKit
import SkeletonView

protocol CategoriesMainPageDataSourceProtocol {
    func update(model: [CategoriesType])
}

final class CategoriesMainPageDataSource: NSObject {

    private var model = [CategoriesType]()

    private let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.contentInset.left = 16
        self.collectionView.contentInset.right = 16
        self.collectionView.backgroundColor(.clear)
        self.collectionView.register(
            CategoriesCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoriesCollectionViewCell.id
        )
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension CategoriesMainPageDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCollectionViewCell.id,
            for: indexPath
        ) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: model[indexPath.row])
        return cell
    }
}

extension CategoriesMainPageDataSource: CategoriesMainPageDataSourceProtocol {
    func update(model: [CategoriesType]) {
        self.model = model
        collectionView.reloadData()
    }
}
