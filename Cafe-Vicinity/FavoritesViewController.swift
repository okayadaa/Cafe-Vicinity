//
//  DetailViewController.swift
//  Cafe-Vicinity
//
//  Created by Ada Muniz on 8/5/25.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private var cafes: [CafeSummary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadFavoriteCafes()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteCafes()
    }
    
    private func loadFavoriteCafes() {
        let all = CafeDataLoader.loadCafeSummariesFromJSON(named: "cafes")
        cafes = CafeDataLoader.loadFavoriteCafes(from: all)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "InfoCell",
            for: indexPath
        ) as? InfoTableViewCell else {
            return UITableViewCell()
        }
        let cafe = cafes[indexPath.row]
        cell.infoName.text = cafe.name
        cell.infoRating.text = String(format: "⭐️ %.1f", cafe.rating)
        cell.infoPricing.text = cafe.priceRange
        cell.infoTransportation.text = cafe.transportation
        cell.infoWebsite.text = cafe.website
        
        if let first = cafe.imageNames.first {
            cell.iconImageView.image = UIImage(named: first)
        } else {
            cell.iconImageView.image = UIImage(systemName: "photo")
        }
        return cell
    }
}
