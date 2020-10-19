//
//  RaceCell.swift
//  SkyTest
//
//  Created by Lorenzo on 16/10/2020.
//

import UIKit

class RaceCellView: UITableViewCell {

    @IBOutlet weak var raceImageView: UIImageView!
    @IBOutlet weak var raceLabel: UILabel!
    @IBOutlet weak var raceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
