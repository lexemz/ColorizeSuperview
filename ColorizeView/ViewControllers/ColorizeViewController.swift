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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {
            return
        }

        settingsVC.colorizeVCSuperViewColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension ColorizeViewController: SettingsViewControllerDelegate {
    func setNewUIColor(for view: UIColor) {
        self.view.backgroundColor = view
    }
}
