//
//  DogsListCollectionViewCell.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import UIKit
import LystExtensions
import LystAssets
import LystModels
import SDWebImage

class DogsListCollectionViewCell: UICollectionViewCell, ReusableCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dogImageView.topOnlyCornerRadius(radiusValue: 10)
        containerView.addSwiftyOutterShadowWithCorner(shadowColor: UIColor.black,
                                                           offSet: CGSize(width: 0, height: 0),
                                                           opacity: 0.12, shadowRadius: 4, cornerRadius: 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dogImageView.image = nil
        dogNameLabel.text = ""
    }
    
    // MARK: - Public -
    
    func configure(with dog: Dog) {
        dogNameLabel.text = dog.name
        if let urlString = dog.image?.url, let imageURL = URL(string: urlString) {
            dogImageView.sd_setImage(with: imageURL, placeholderImage: Asset.splashLogo.image)
        } else {
            dogImageView.image = Asset.splashLogo.image
        }
    }

}
