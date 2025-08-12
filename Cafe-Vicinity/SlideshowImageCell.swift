//
//  SlideshowImageCell.swift
//  Cafe-Vicinity
//
//  Created by Ada Muniz on 8/4/25.
//

import UIKit

class SlideshowImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private let labelBackground = UIView()
    private let gradientLayer = CAGradientLayer()
    
    var labelText: String? {
            didSet {
                nameLabel.text = labelText
                let empty = (labelText?.isEmpty ?? true)
                nameLabel.isHidden = empty
                labelBackground.isHidden = empty
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView?.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .white
        
        setupLabelBackground()
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let corner: CGFloat = 10
        labelBackground.layer.cornerRadius = corner
        labelBackground.clipsToBounds = true
        
        gradientLayer.frame = labelBackground.bounds
        gradientLayer.cornerRadius = corner
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            imageView.image = nil
            nameLabel.text = nil
            nameLabel.isHidden = true
            labelBackground.isHidden = true
            gradientLayer.isHidden = true
        }
    
    private func setupLabelBackground() {
        labelBackground.translatesAutoresizingMaskIntoConstraints = false
        labelBackground.backgroundColor = .clear
        contentView.addSubview(labelBackground)
        contentView.bringSubviewToFront(nameLabel)
        
            NSLayoutConstraint.activate([
                labelBackground.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -10),
                labelBackground.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
                labelBackground.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -6),
                labelBackground.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6)
            ])
        }

    private func setupGradient() {
            // Subtle dark gradient for readability
            gradientLayer.colors = [
                UIColor.black.withAlphaComponent(0.35).cgColor,
                UIColor.black.withAlphaComponent(0.15).cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint   = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.isHidden = true
            labelBackground.layer.insertSublayer(gradientLayer, at: 0)
        }

    
    func setLabelGradientBackground(visible: Bool) {
            gradientLayer.isHidden = !visible
        }

        // Convenience configure
        func configure(imageName: String?, name: String?, gradientVisible: Bool) {
            if let img = imageName { imageView.image = UIImage(named: img) }
            labelText = name
            setLabelGradientBackground(visible: gradientVisible && !(name?.isEmpty ?? true))
        }
}
