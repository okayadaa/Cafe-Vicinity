//
//  InfoTableViewCell.swift
//  Cafe-Vicinity
//
//  Created by Ada Muniz on 8/6/25.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var infoName: UILabel!
    
    @IBOutlet weak var infoRating: UILabel!
    
    @IBOutlet weak var infoTransportation: UILabel!
    
    @IBOutlet weak var infoWebsite: UILabel!
    
    @IBOutlet weak var infoPricing: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("InfoTableViewCell loaded")
        print("iconImageView: \(iconImageView != nil)")
        print("infoName: \(infoName != nil)")
        print("infoRating: \(infoRating != nil)")
        print("infoPricing: \(infoPricing != nil)")
        print("infoTransportation: \(infoTransportation != nil)")
        print("infoWebsite: \(infoWebsite != nil)")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
