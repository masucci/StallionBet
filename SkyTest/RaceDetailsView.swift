//
//  RaceDetailsView.swift
//  SkyTest
//
//  Created by Lorenzo on 16/10/2020.
//

import UIKit

class RaceDetailsView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var raceName: UILabel!
    @IBOutlet weak var courseName: UILabel!
    
    
    var name = ""
    var ridesInfo: [Ride] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 162, left: 0, bottom: 0, right: 0)
        raceName.text = name
        courseName.text = name
        
        var cellNib = UINib(nibName: "OddCell", bundle: nil)
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
        
        return cell
    }
    
}
