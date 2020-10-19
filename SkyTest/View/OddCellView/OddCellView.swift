//
//  OddCellView.swift
//  SkyTest
//
//  Created by Lorenzo on 16/10/2020.
//

import UIKit

class OddCellView: UITableViewCell {

    @IBOutlet weak var clothNumberLabel: UILabel!
    @IBOutlet weak var horseLabel: UILabel!
    @IBOutlet weak var oddButton: UIButton!
    @IBOutlet weak var formLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(clothNumber: String, horseName: String, formSummary: String, currentOdds: String) {
        clothNumberLabel.text = "Cloth Number: \(clothNumber)"
        horseLabel.text = "Horse: \(horseName)"
        formLabel.text = "Form: \(formSummary)"
        oddButton.setTitle(currentOdds, for: .normal)
        
    }
}
