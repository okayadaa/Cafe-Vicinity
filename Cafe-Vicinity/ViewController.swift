//
//  ViewController.swift
//  Cafe-Vicinity
//
//  Created by Ada Muniz on 8/1/25.
//

import UIKit
    
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Homescreen vertical paging
    @IBOutlet weak var outerCollectionView: UICollectionView!
    
    private var cafes = [CafeSummary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("outerCollectionView is nil? ->", outerCollectionView == nil)
        
        cafes = CafeDataLoader.loadCafeSummariesFromJSON(named: "cafes")
        
        // Apply favorite flags from stored favorite IDs
        let favoriteIDs = Set(CafeDataLoader.loadFavoriteIDs())
        for i in cafes.indices {
            cafes[i].isFavorite = favoriteIDs.contains(cafes[i].id)
        }
        
        print("Loaded cafes:",cafes.count)
        
        outerCollectionView.dataSource = self
        outerCollectionView.delegate = self
        
        //Setting vertical paging layout
        if let layout = outerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .vertical
        }
        outerCollectionView.isPagingEnabled = true
        outerCollectionView.clipsToBounds = true
        outerCollectionView.decelerationRate = .fast
        outerCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cafes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "SlideshowCell",
                for: indexPath
            ) as? SlideshowCell else {
                return UICollectionViewCell()
            }

            let cafe = cafes[indexPath.item]

            // Feed the inner slideshow
            cell.imageNames = cafe.imageNames
            cell.labelNames = Array(repeating: cafe.name, count: cafe.imageNames.count)

            // Initial favorite state
            cell.favoriteButton.isSelected = cafe.isFavorite
            cell.favoriteButton.setImage(
                UIImage(systemName: cafe.isFavorite ? "star.fill" : "star"),
                for: .normal
            )

            // Callback for the cell's favorite button
            cell.onFavoriteTapped = { [weak self, weak cell] in
                guard let self = self,
                      let cell = cell,
                      let idx = collectionView.indexPath(for: cell)?.item,
                      self.cafes.indices.contains(idx) else { return }

                self.cafes[idx].isFavorite.toggle()
                let isFav = self.cafes[idx].isFavorite

                // Persist by ID
                if isFav {
                    CafeDataLoader.addFavorite(id: self.cafes[idx].id)
                } else {
                    CafeDataLoader.removeFavorite(id: self.cafes[idx].id)
                }

                // Update the button image
                cell.favoriteButton.isSelected = isFav
                cell.favoriteButton.setImage(
                    UIImage(systemName: isFav ? "star.fill" : "star"),
                    for: .normal
                )
            }

            return cell
        }
        
        //Cell sizing
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return collectionView.bounds.size
        }
    }

