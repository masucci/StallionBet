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
    @IBOutlet weak var bannerView: UIView!
    
    
    var raceName = ""
    var courseName = ""
    
    var ridesInfo: [Ride] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        raceNameLabel.text = raceName
        courseNameLabel.text = courseName
       
        let cellNib = UINib(nibName: "OddCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "OddCell")
        
        bannerView.layer.cornerRadius = bannerView.frame.height / 8
        
        
    }

    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        let filterMenu = UIAlertController(title: "Order by:", message: "Choose Option", preferredStyle: .actionSheet)
        
        let orderByClothNumber = UIAlertAction(title: "Cloth Number", style: .default) { (_) in
            self.ridesInfo = self.ridesInfo.sorted{ $0.cloth_number < $1.cloth_number }
            self.tableView.reloadData()
        }

        let orderByOdds = UIAlertAction(title: "Odds", style: .default) { (_) in
            self.ridesInfo = self.ridesInfo.sorted{ self.getOddsValue($0.current_odds)  < self.getOddsValue($1.current_odds) }
            self.tableView.reloadData()
        }
        
        let orderByForm = UIAlertAction(title: "Form", style: .default) { (_) in
            self.ridesInfo = self.ridesInfo.sorted{ self.getFormValue($0.formsummary) > self.getFormValue($1.formsummary) }
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        filterMenu.addAction(orderByClothNumber)
        filterMenu.addAction(orderByOdds)
        filterMenu.addAction(orderByForm)
        filterMenu.addAction(cancelAction)
        
        self.present(filterMenu, animated: true, completion: nil)
    }
    
    func getOddsValue(_ value: String) -> Float {
        if value.contains("/") {
            let oddValues = value.split(separator: "/")
            return Float(oddValues[0])!/Float(oddValues[1])!
        }
        return 0
    }
    
    func getFormValue(_ element: String) -> Int {
        var value = 0
        for character in element {
            switch character {
            case "0":
                value += 0
            case "1":
                value += 9
            case "2":
                value += 8
            case "3":
                value += 7
            case "4":
                value += 6
            case "5":
                value += 5
            case "6":
                value += 4
            case "7":
                value += 3
            case "8":
                value += 2
            case "9":
                value += 1
            default:
                value += 0
            }
        }
        return value
    }

}



extension RaceDetailsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ridesInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OddCell", for: indexPath) as! OddCellView
        cell.configureCell(clothNumber: String(ridesInfo[indexPath.row].cloth_number),
                           horseName: ridesInfo[indexPath.row].horse.name, formSummary: ridesInfo[indexPath.row].formsummary,
                           currentOdds: ridesInfo[indexPath.row].current_odds)

        cell.oddButton.tag = indexPath.row
        cell.oddButton.addTarget(self, action: #selector(openSkyBetOnline(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    
    @objc func openSkyBetOnline(_ sender: UIButton) {
        let vc = SFSafariViewController(url: URL(string: "https://m.skybet.com/horse-racing")!)
        self.present(vc, animated: true, completion: nil)
    }
}


