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
    @IBOutlet weak var raceName: UILabel!
    @IBOutlet weak var courseName: UILabel!
    
    
    var name = ""
    var ridesInfo: [Ride] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        raceName.text = name
        courseName.text = name
        
        let cellNib = UINib(nibName: "OddCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "OddCell")
        
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
