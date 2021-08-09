//
//  DisablingButton.swift
//  LystTestApp
//
//  Created by Mohsin Hussain on 09/08/2021.
//

import UIKit
import LystAssets

class DisablingButton: UIButton {

    var disabledText: String = ""
    var enabledText: String = ""

    func setText(disabledText: String, enabledText: String) {
        self.disabledText = disabledText
        self.enabledText = enabledText
        update()
    }
    override func awakeFromNib() {
        self.backgroundColor = .darkGray
    }

    @IBInspectable var disabledColor: UIColor = .lightGray {
        didSet { update() }
    }

    override var isEnabled: Bool {
        didSet { update() }
    }

    // MARK: - Private -
    
    private func update() {
        UIView.animate(withDuration: 0.25) {
            if self.isEnabled {
                self.backgroundColor = .darkGray
                self.setTitle(self.enabledText, for: .normal)
            } else {
                self.backgroundColor = self.disabledColor
                self.setTitle(self.disabledText, for: .normal)
            }
        }
    }
}
