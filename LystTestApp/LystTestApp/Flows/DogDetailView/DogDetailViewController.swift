//
//  DogDetailViewController.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 09/08/2021.
//

import UIKit
import LystAssets

class DogDetailViewController: MainViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var nameView: UIStackView!
    @IBOutlet weak var breedNameView: UIStackView!
    @IBOutlet weak var bredForView: UIStackView!
    @IBOutlet weak var lifeSpanView: UIStackView!
    @IBOutlet weak var tempramentView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breedNameLabel: UILabel!
    @IBOutlet weak var bredForLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var tempramentLabel: UILabel!
    @IBOutlet weak var mainView: UIStackView!
    
    
    var viewModel = DogDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTexts()
        
    }

}

extension DogDetailViewController {
    private func setupTexts() {
        if let dog = viewModel.getDog() {
            title = "Dog Details"
            bredForLabel.text = dog.bred_for
            lifeSpanLabel.text = dog.life_span
           
            if !dog.name.isEmpty {
                nameLabel.text = dog.name
            } else {
                nameView.isHidden = true
            }
            
            if !dog.breed_group.isEmpty {
                breedNameLabel.text = dog.breed_group
            } else {
                breedNameView.isHidden = true
            }
            
            if !dog.temperament.isEmpty {
                tempramentLabel.text = dog.temperament
            } else {
                tempramentView.isHidden = true
            }
            
            if !dog.bred_for.isEmpty {
                bredForLabel.text = dog.bred_for
            } else {
                bredForView.isHidden = true
            }
            
            if !dog.life_span.isEmpty {
                lifeSpanLabel.text = dog.life_span
            } else {
                lifeSpanView.isHidden = true
            }
            
            if let urlString = dog.image?.url, let imageURL = URL(string: urlString) {
                dogImageView.sd_setImage(with: imageURL, placeholderImage: Asset.splashLogo.image)
            } else {
                dogImageView.image = Asset.splashLogo.image
            }
        } else {
            title = "No Details Found"
            dogImageView.isHidden = true
            mainView.isHidden = true
        }
        
    }
}
