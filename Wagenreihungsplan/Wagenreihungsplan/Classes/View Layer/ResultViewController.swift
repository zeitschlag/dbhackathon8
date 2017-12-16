//
//  ResultViewController.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 16.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var prefixLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    
    var result: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let result = self.result else {
            return
        }
        
        self.view.backgroundColor = Branding.Colors.DBBlue
        
        //TODO: Set Attributed Labels
        self.prefixLabel.textColor = Branding.Colors.White
        self.prefixLabel.text = NSLocalizedString("Please go to", comment: "")
        
        self.platformLabel.textColor = Branding.Colors.White
        if let platform = result.platform {
            self.platformLabel.text = "Platform \(platform)"
        } else {
            self.platformLabel.isHidden = true
        }
        
        self.sectionLabel.textColor = Branding.Colors.White
        
        var sectionLabelText = "Section "
        
        if let sections = result.sections {
            if sections.count > 1 {
                sectionLabelText += sections.joined(separator: ", ")
            } else if sections.count == 1 {
                sectionLabelText += sections[0]
            }
        } else {
            self.sectionLabel.isHidden = true
        }

        self.sectionLabel.text = sectionLabelText
        
        self.closeButton.setTitle(NSLocalizedString("Close", comment: ""), for: .normal)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
