//
//  ViewController.swift
//  ColorizeView
//
//  Created by Igor on 03.09.2021.
//

import UIKit


protocol SettingsViewControllerDelegate {
    func setNewUIColor(for view: UIColor)
}

class ColorizeViewController: UIViewController {
    
    @IBOutlet var superView: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {
            return
        }

        settingsVC.colorizeVCColor = superView.backgroundColor
        settingsVC.delegate = self
    }
}

extension ColorizeViewController: SettingsViewControllerDelegate {
    func setNewUIColor(for view: UIColor) {
        superView.backgroundColor = view
    }
}
