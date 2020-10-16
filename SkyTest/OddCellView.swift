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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func oddButtonPressed(_ sender: UIButton) {
    }
    
    func configureCell(for result: [Ride], indexPath: IndexPath) {
        clothNumberLabel.text = String(result[indexPath.row].cloth_number)
        horseLabel.text = result[indexPath.row].horse.name
        oddButton.titleLabel?.text = result[indexPath.row].current_odds
        
    }
}
