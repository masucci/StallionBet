//
//  ViewController.swift
//  SkyTest
//
//  Created by Lorenzo on 16/10/2020.
//

import UIKit
import LocalAuthentication

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performRequest()
        
    }
    
    var raceInfo = [RaceInfo]()

    /* AUTHENTICATION TEST
    func authentication() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        print("Success")
                        self!.performRequest()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self!.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
 */
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
        let url = jsonURL(url: "https://api.jsonbin.io/b/5f89471d7243cd7e824fd710")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            self.raceInfo = self.parse(data: data)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        dataTask.resume()
    }
    
    //MARK: - TableView Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return raceInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = raceInfo[indexPath.row].race_summary.course_name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Rides", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Rides" {
            let indexPath = sender as! IndexPath
            let view = segue.destination as! RaceDetailsView
            view.name = raceInfo[indexPath.row].race_summary.name
            view.ridesInfo = raceInfo[indexPath.row].rides
        }
    }
    
}


