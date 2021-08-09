//
//  EmptyListPlaceHolderView.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 09/08/2021.
//

import UIKit
import LystAssets

class EmptyListPlaceHolderView: UIView {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - Lifecycle -
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let views = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil),
            let view = views.first as? UIView {
            view.frame = bounds
            addSubview(view)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTexts()
        logoImageView.image = Asset.splashLogo.image

    }
    
    // MARK: - Private -
    
    private func setupTexts() {
        descriptionLabel?.attributedText = NSAttributedString(string: "No search result found, Please search something else. Sorry for inconvience. ")
    }
    
    // MARK: - Public -
    
    func set(description: String) {
        descriptionLabel?.attributedText = NSAttributedString(string: description)
    }
    
    func set(description: String, underLinedBoldText: String) {
        let underlinedSemiBoldFont: [NSAttributedString.Key: Any] = [.font: FontFamily.SourceSansPro.semiBold.font(size: 12) ??
                                                                            Font.boldSystemFont(ofSize: 12), .underlineStyle: NSUnderlineStyle.single.rawValue]

        let descriptionString = NSAttributedString(string: description)
        let underLinedBoldTextString = NSAttributedString(string: underLinedBoldText, attributes: underlinedSemiBoldFont)

        let combinedString = NSMutableAttributedString()
        combinedString.append(descriptionString)
        combinedString.append(NSAttributedString(string: " "))
        combinedString.append(underLinedBoldTextString)

        descriptionLabel?.attributedText = combinedString
    }
    
}
