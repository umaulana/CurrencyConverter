//
//  GradientView.swift
//  CurrencyConverter
//
//  Created by umam on 26/01/23.
//

import UIKit

class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.systemBackground.cgColor, UIColor.magenta.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                gradientLayer.colors = [UIColor.systemBackground.cgColor, UIColor.magenta.cgColor]
            }
        }
    }
}
