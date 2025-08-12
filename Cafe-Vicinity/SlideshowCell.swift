//
//  SlideshowCell.swift
//  Cafe-Vicinity
//
//  Created by Ada Muniz on 8/2/25.
//

import UIKit

class SlideshowCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var innerCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        onFavoriteTapped?()
    }
    var onFavoriteTapped: (() -> Void)?
    
    var imageNames: [String] = [] { didSet { innerCollectionView?.reloadData() } }
    var labelNames: [String] = [] { didSet { innerCollectionView?.reloadData() } }

        override func awakeFromNib() {
            super.awakeFromNib()
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.isPagingEnabled = true
            contentView.bringSubviewToFront(favoriteButton)
            if let layout = innerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
                layout.minimumLineSpacing = 0
                layout.estimatedItemSize = .zero
            }
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            imageNames.count
        }

        func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "SlideshowImageCell",
                for: indexPath
            ) as! SlideshowImageCell

            let imageName = imageNames[indexPath.item]
            cell.imageView.image = UIImage(named: imageName)
            cell.labelText = labelNames.indices.contains(indexPath.item) ? labelNames[indexPath.item] : nil
            
            return cell
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            collectionView.bounds.size
    }
}
