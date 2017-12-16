//
//  TrainStationTableViewController.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 16.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import UIKit

protocol TrainStationTableViewControllerDelegate {
    func didSelectTrainStation(_ trainStation: Station)
}

class TrainStationTableViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: TrainStationTableViewControllerDelegate?
    
    var selectedStation: Station?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.doneButton.setTitleColor(Branding.Colors.DBBlue, for: .normal)
        self.doneButton.setTitle(NSLocalizedString("OK", comment: ""), for: .normal)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: - Actions
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension TrainStationTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell", for: indexPath)
        
        let station = DataManager.shared.stations[indexPath.row]
        cell.textLabel?.text = station.name
        
        if station == selectedStation {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
        
    }
}

extension TrainStationTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedStation = DataManager.shared.stations[indexPath.row]
        
    self.delegate?.didSelectTrainStation(DataManager.shared.stations[indexPath.row])
        
        tableView.reloadData()
    }
}
