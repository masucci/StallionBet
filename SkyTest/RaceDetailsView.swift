//
//  RaceDetailsView.swift
//  SkyTest
//
//  Created by Lorenzo on 16/10/2020.
//

import UIKit
import SafariServices


class RaceDetailsView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var raceNameLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    
    var raceName = ""
    var courseName = ""
    
    var ridesInfo: [Ride] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        raceNameLabel.text = raceName
        courseNameLabel.text = courseName
        
        let cellNib = UINib(nibName: "OddCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "OddCell")
        
    }
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        let filterMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let orderByClothNumber = UIAlertAction(title: "Cloth", style: .default) { [self] (alertAction) in
            ridesInfo = ridesInfo.filter{$0.cloth_number.isMultiple(of: 1)}.sorted{ $0.cloth_number < $1.cloth_number }
            tableView.reloadData()
        }
//        let orderByOdds = ""
//        let orderByForm = ""
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        filterMenu.addAction(orderByClothNumber)
        filterMenu.addAction(cancelAction)
        
        self.present(filterMenu, animated: true, completion: nil)
    }
    

}

extension RaceDetailsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ridesInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OddCell", for: indexPath) as! OddCellView
        cell.configureCell(for: ridesInfo, indexPath: indexPath)
        
        cell.oddButton.tag = indexPath.row
        cell.oddButton.addTarget(self, action: #selector(openSkyBetOnline(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func openSkyBetOnline(_ sender: UIButton) {
        let vc = SFSafariViewController(url: URL(string: "https://m.skybet.com/horse-racing")!)
        self.present(vc, animated: true, completion: nil)
    }
}
