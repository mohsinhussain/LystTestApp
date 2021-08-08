//
//  DogsListCollectionViewCell.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import UIKit
import LystExtensions
import LystAssets

class DogsListCollectionViewCell: UICollectionViewCell, ReusableCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dogImageView.layer.cornerRadius = 10.0
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
    
    func configure() {
        dogNameLabel.text = "German Shephard"
        dogImageView.image = Asset.splashLogo.image
    }

}
