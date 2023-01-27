//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by umam on 27/01/23.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    @IBOutlet private weak var symbolContainerView: UIView!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        symbolContainerView.layer.borderColor = UIColor.magenta.cgColor
        symbolContainerView.layer.borderWidth = 2
        symbolContainerView.layer.cornerRadius = 4
    }
    
    func configure(viewParam: CurrencyCellViewParam) {
        symbolLabel.text = viewParam.symbol
        valueLabel.text = viewParam.value
    }
}
