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
        let prefixLabelString = NSLocalizedString("Please go to", comment: "")
        self.prefixLabel.attributedText = NSAttributedString(string: prefixLabelString, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.regular)])
        
        self.platformLabel.textColor = Branding.Colors.White // 36,48
        if let platform = result.platform {
            let attributedPlatformPrefix = NSAttributedString(string: NSLocalizedString("Platform ", comment: ""), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 36.0, weight: UIFont.Weight.light)])
            
            let attributedPlatformText = NSAttributedString(string: "\(platform)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 48.0, weight: UIFont.Weight.bold)])
            
            let attributedPlatformLabelText = NSMutableAttributedString(attributedString: attributedPlatformPrefix)
            attributedPlatformLabelText.append(attributedPlatformText)
            
            self.platformLabel.attributedText = attributedPlatformLabelText
            
        } else {
            self.platformLabel.isHidden = true
        }
        
        self.sectionLabel.textColor = Branding.Colors.White
        
        if let sections = result.sections, sections.count > 0 {
            
            var sectionsText = ""
            var sectionPrefixText = ""
            if sections.count > 1 {
                sectionPrefixText = NSLocalizedString("Sections ", comment: "")
                sectionsText = sections.joined(separator: ", ")
            } else if sections.count == 1 {
                sectionPrefixText = NSLocalizedString("Section ", comment: "")
                sectionsText = sections[0]
            }
            
            let attributedSectionPrefix = NSAttributedString(string: sectionPrefixText, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 36.0, weight: UIFont.Weight.light)])
            let attributedSectionsText = NSAttributedString(string: sectionsText, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 48.0, weight: UIFont.Weight.bold)])
        
            let attributedSectionLabelText = NSMutableAttributedString(attributedString: attributedSectionPrefix)
            attributedSectionLabelText.append(attributedSectionsText)
            
            self.sectionLabel.attributedText = attributedSectionLabelText
            
        } else {
            self.sectionLabel.isHidden = true
        }
     
        self.closeButton.setTitleColor(Branding.Colors.White, for: .normal)
        self.closeButton.setTitle(NSLocalizedString("Close", comment: ""), for: .normal)
        self.closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
