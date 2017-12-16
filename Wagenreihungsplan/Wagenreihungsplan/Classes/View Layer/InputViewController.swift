//
//  ViewController.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 15.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import UIKit

struct UserInput {
    var station: Station?
    var trainNumber: String?
    var waggonNumber: Int?
}

class InputViewController: UIViewController {
    
    var userInput = UserInput()
    
    //MARK: - Outlets
    @IBOutlet weak var trainNumberLabel: UILabel!
    @IBOutlet weak var trainNumberTextfield: UITextField!
    
    @IBOutlet weak var trainStationLabel: UILabel!
    @IBOutlet weak var selectTrainStationButton: UIButton!
    
    @IBOutlet weak var reservationNumberLabel: UILabel!
    @IBOutlet weak var reservationNumberTextfield: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Apply fonts
        trainNumberLabel.text = NSLocalizedString("Train Number", comment: "")
        trainNumberLabel.textColor = Branding.Colors.DBBlue
        
        trainNumberTextfield.delegate = self
        
        trainStationLabel.text = NSLocalizedString("Train Station", comment: "")
        trainStationLabel.textColor = Branding.Colors.DBBlue
        
        selectTrainStationButton.setTitle(NSLocalizedString("Please select", comment: ""), for: .normal)
        selectTrainStationButton.setTitleColor(Branding.Colors.DBBlue, for: .normal)
        
        selectTrainStationButton.layer.borderColor = Branding.Colors.DBBlue.cgColor
        selectTrainStationButton.layer.borderWidth = 2.0
        selectTrainStationButton.layer.cornerRadius = 19.5
        
        
        //TODO: Attributed String
        reservationNumberLabel.text = NSLocalizedString("Reservation Number (optional)", comment: "")
        reservationNumberLabel.textColor = Branding.Colors.DBBlue
        
        reservationNumberTextfield.delegate = self
        
        doneButton.setTitle(NSLocalizedString("OK", comment: ""), for: .normal)
        doneButton.layer.borderColor = Branding.Colors.DBBlue.cgColor
        doneButton.layer.borderWidth = 2.0
        doneButton.layer.cornerRadius = 19.5
        
        doneButton.setTitleColor(Branding.Colors.DBBlue, for: .normal)
    }
    
    //MARK: - Actions
    
    @IBAction func selectTrainStationButtonTapped(_ sender: Any) {
        //TODO: Move this to a coordinator
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let trainStationTableViewController = mainStoryboard.instantiateViewController(withIdentifier: "TrainStationTableViewController") as? TrainStationTableViewController else {
            fatalError("No TrainStationTableViewController")
        }
        
        trainStationTableViewController.delegate = self
        
        if let selectedStation = userInput.station {
            trainStationTableViewController.selectedStation = selectedStation
        }
        
        self.present(trainStationTableViewController, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        //TODO: Add validation
        guard let unrappedTrainNumber = self.userInput.trainNumber, let trainNumber = Int(unrappedTrainNumber) else { return }
        guard let station = self.userInput.station else { return }
        
        if let result = DataManager.shared.getResult(withStation: station, trainNumber: trainNumber, waggonNumber: self.userInput.waggonNumber) {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let resultViewController = mainStoryboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else {
                fatalError("No ResultViewController")
            }
            
            resultViewController.result = result
            
            self.present(resultViewController, animated: true, completion: nil)
            
        } else {
            
            let alertController = UIAlertController(title: NSLocalizedString("Sorry", comment: ""), message: "We couldn't find a section for this connection.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            
            alertController.addAction(okAction)
            
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension InputViewController: TrainStationTableViewControllerDelegate {
    func didSelectTrainStation(_ trainStation: Station) {
        
        self.userInput.station = trainStation
        
        OperationQueue.main.addOperation {
            self.selectTrainStationButton.setTitle(trainStation.name, for: .normal)
        }
        
    }
    
}

extension InputViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.trainNumberTextfield {
            self.userInput.trainNumber = textField.text
        } else if textField == self.reservationNumberTextfield {
            self.userInput.waggonNumber = Int(textField.text ?? "0")
        }
    }
}
