//
//  TickersTableViewCell.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 20/10/23.
//

import UIKit

class TickersListItemCell: UITableViewCell {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latestClosePriceLabel: UILabel!
    @IBOutlet weak var stockAcronymLabel: UILabel!
    @IBOutlet weak var stockCountryLabel: UILabel!
    
    func configure(with item: TickersListItemViewModel) {
        symbolLabel.text = item.symbol
        nameLabel.text = item.name
        latestClosePriceLabel.text = "Latest end-to-day close price not provided by API"
        stockAcronymLabel.text = item.acronym
        stockCountryLabel.text = item.country
    }

}
