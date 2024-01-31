//
//  HistoricalReadTableViewCell.swift
//  EnergyCostCalculator
//
//  Created by Melis Akin on 13.01.2024.
//

import UIKit

class HistoricalReadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currentIndexLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
