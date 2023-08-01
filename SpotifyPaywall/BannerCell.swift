//
//  BannerCell.swift
//  SpotifyPaywall
//
//  Created by 최지연/클라이언트 on 2023/08/01.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
    }
    
    func configure(_ info: BannerInfo) {
        thumbnailImageView.image = UIImage(named: info.imageName)
        titleLabel.text = info.title
        descriptionLabel.text = info.description
    }
}
