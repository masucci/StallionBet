//
//  RaceViewController.swift
//  SkyTest
//
//  Created by Lorenzo on 16/10/2020.
//

import UIKit

class RaceViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        performRequest()
        tableView.separatorStyle = .none
        
        var cellNib = UINib(nibName: "RaceCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "RaceCell")
        
        cellNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "LoadingCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    var raceInfo = [RaceInfo]()
    let imageShields = [UIImage(named: "Shield1"), UIImage(named: "Shield2"),UIImage(named: "Shield3"),UIImage(named: "Shield4"),UIImage(named: "Shield5"),UIImage(named: "Shield6"),UIImage(named: "Shield7"),UIImage(named: "Shield8"), UIImage(named: "Shield9"),UIImage(named: "Shield10") ]
    var isLoading = false
    
    //MARK: - Helper Methods
    func jsonURL(url: String) -> URL {
        let url = URL(string: url)
        return url!
    }
    
    func parse(data: Data) -> [RaceInfo] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Races.self, from: data)
            return result.races
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
    
    func performRequest() {
        isLoading = true
        let url = jsonURL(url: "https://api.jsonbin.io/b/5f89471d7243cd7e824fd710/1")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            self.raceInfo = self.parse(data: data)
            
            DispatchQueue.main.async {
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
        dataTask.resume()
    }
    
    //MARK: - TableView Methods

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 1
        } else {
            return raceInfo.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaceCell", for: indexPath) as! RaceCellView
        cell.raceLabel.text = raceInfo[indexPath.row].race_summary.course_name
        cell.raceImageView.image = imageShields[indexPath.row]
        cell.raceView.layer.cornerRadius = cell.raceView.frame.height / 4
        return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "Rides", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Rides" {
            let indexPath = sender as! IndexPath
            let view = segue.destination as! RaceDetailsView
            view.raceName = raceInfo[indexPath.row].race_summary.name
            view.courseName = raceInfo[indexPath.row].race_summary.course_name
            view.ridesInfo = raceInfo[indexPath.row].rides
        }
    }
    
}


