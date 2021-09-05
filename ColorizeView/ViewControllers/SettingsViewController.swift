//
//  SettingsViewController.swift
//  ColorizeView
//
//  Created by Igor on 03.09.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var previewView: UIView! {
        didSet {
            previewView.layer.cornerRadius = 10
            previewView.backgroundColor = colorizeVCColor
        }
    }

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!

    @IBOutlet var redValueField: UITextField!
    @IBOutlet var greenValueField: UITextField!
    @IBOutlet var blueValueField: UITextField!
    
    var colorizeVCColor: UIColor!
    var delegate: SettingsViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.value = colorizeVCColor.redValue
        greenSlider.value = colorizeVCColor.greenValue
        blueSlider.value = colorizeVCColor.blueValue
        
        redValueLabel.text = getRoundedStrValue(from: redSlider)
        greenValueLabel.text = getRoundedStrValue(from: greenSlider)
        blueValueLabel.text = getRoundedStrValue(from: blueSlider)
        
        redValueField.text = redValueLabel.text
        greenValueField.text = greenValueLabel.text
        blueValueField.text = blueValueLabel.text
    }
    
    @IBAction func sliderIsMoved(_ sender: UISlider) {
        switch sender {
        case redSlider:
            let redRoundedValue = getRoundedStrValue(from: redSlider)
            
            redValueLabel.text = redRoundedValue
            redValueField.text = redRoundedValue
        case greenSlider:
            let greenRoundedValue = getRoundedStrValue(from: greenSlider)
            
            greenValueLabel.text = greenRoundedValue
            greenValueField.text = greenRoundedValue
        default:
            let blueRoundedValue = getRoundedStrValue(from: blueSlider)
            
            blueValueLabel.text = blueRoundedValue
            blueValueField.text = blueRoundedValue
        }
        
        colorizeView()
    }
    
    @IBAction func DoneBtnPressed() {
        guard let previewColor = previewView.backgroundColor else { return }
        
        delegate.setNewUIColor(for: previewColor)
        
        dismiss(animated: true, completion: nil)
    }
    
    private func getRoundedStrValue(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func colorizeView() {
        previewView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

// UIColor chenels values return
extension UIColor {
    var redValue: Float { Float(CIColor(color: self).red) }
    var greenValue: Float { Float(CIColor(color: self).green) }
    var blueValue: Float { Float(CIColor(color: self).blue) }
}
