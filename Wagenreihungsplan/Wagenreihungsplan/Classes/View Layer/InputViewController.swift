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
        
        trainNumberLabel.text = NSLocalizedString("Train Number", comment: "")
        trainNumberLabel.textColor = Branding.Colors.DBBlue
        trainNumberLabel.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        
        trainNumberTextfield.delegate = self
        trainNumberTextfield.backgroundColor = Branding.Colors.DBGrey
        trainNumberTextfield.layer.cornerRadius = 10.0
        trainNumberTextfield.layoutMargins = UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)
        trainNumberTextfield.textAlignment = .center
        
        trainStationLabel.text = NSLocalizedString("Train Station", comment: "")
        trainStationLabel.textColor = Branding.Colors.DBBlue
        trainStationLabel.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        
        selectTrainStationButton.setTitle(NSLocalizedString("Please select", comment: ""), for: .normal)
        selectTrainStationButton.setTitleColor(Branding.Colors.DBBlue, for: .normal)
        
        selectTrainStationButton.layer.borderColor = Branding.Colors.DBBlue.cgColor
        selectTrainStationButton.layer.borderWidth = 2.0
        selectTrainStationButton.layer.cornerRadius = 19.5
        
        let waggonNumberPrefix = NSAttributedString(string: NSLocalizedString("Waggon Number", comment: ""), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)])
        let waggonNumberOptional = NSAttributedString(string: " (optional)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.light)])
        
        let attributedWaggonNumberString = NSMutableAttributedString(attributedString: waggonNumberPrefix)
        attributedWaggonNumberString.append(waggonNumberOptional)
        
        reservationNumberLabel.attributedText = attributedWaggonNumberString
        reservationNumberLabel.textColor = Branding.Colors.DBBlue
        
        reservationNumberTextfield.delegate = self
        reservationNumberTextfield.backgroundColor = Branding.Colors.DBGrey
        reservationNumberTextfield.layer.cornerRadius = 10.0
        reservationNumberTextfield.layoutMargins = UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)
        reservationNumberTextfield.textAlignment = .center
        
        doneButton.setTitle(NSLocalizedString("OK", comment: ""), for: .normal)
        doneButton.layer.borderColor = Branding.Colors.DBBlue.cgColor
        doneButton.layer.borderWidth = 2.0
        doneButton.layer.cornerRadius = 19.5
        
        doneButton.setTitleColor(Branding.Colors.DBBlue, for: .normal)
        self.doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)

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
        //TODO: Move this away from the view controller
        guard let unrappedTrainNumber = self.trainNumberTextfield.text, let trainNumber = Int(unrappedTrainNumber) else { return }
        guard let station = self.userInput.station else { return }
        
        var waggonNumber: Int?
        
        if let waggonNumberInput = self.reservationNumberTextfield.text {
            waggonNumber = Int(waggonNumberInput)
        }
        
        if let result = DataManager.shared.getResult(withStation: station, trainNumber: trainNumber, waggonNumber: waggonNumber) {
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
