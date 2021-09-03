//
//  ViewController.swift
//  ColorizeView
//
//  Created by Igor on 03.09.2021.
//

import UIKit

class ColorizeViewController: UIViewController {
    
    @IBOutlet var colorizeView: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {
            return
        }

        settingsVC.colorizeVCColor = colorizeView.backgroundColor
    }
}

