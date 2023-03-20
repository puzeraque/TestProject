import UIKit
import SkeletonView

protocol LatestMainPageDataSourceProtocol {
    var onProductSelected: VoidHandler? { get set }
    func update(model: [ProductCollectionViewCell.Model])
}

final class LatestMainPageDataSource: NSObject {

    var onProductSelected: VoidHandler?

    private var model = [ProductCollectionViewCell.Model]()

    private let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.backgroundColor(.clear)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.contentInset.left = 16
        self.collectionView.contentInset.right = 16
        self.collectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.id
        )
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension LatestMainPageDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.isEmpty ? 3 : model.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.id,
            for: indexPath
        ) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        guard model.isNotEmpty else {
            cell.isSkeletonable = true
            cell.showSkeletonWithAnimation()
            return cell
        }
        let latestProduct = model[indexPath.row]

        cell.hideSkeleton()
        cell.configure(with: latestProduct)
        cell.onTap { [weak self] in
            self?.onProductSelected?()
        }
        return cell
    }
}

extension LatestMainPageDataSource: LatestMainPageDataSourceProtocol {
    func update(model: [ProductCollectionViewCell.Model]) {
        self.model = model
        collectionView.reloadData()
    }
}
