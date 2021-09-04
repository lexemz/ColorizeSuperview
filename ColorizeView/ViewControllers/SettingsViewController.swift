//
//  SettingsViewController.swift
//  ColorizeView
//
//  Created by Igor on 03.09.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var colorPreview: UIView! {
        didSet {
            colorPreview.layer.cornerRadius = 10
            colorPreview.backgroundColor = colorizeVCColor
        }
    }

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!

    var colorizeVCColor: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.value = colorizeVCColor.redValue
        greenSlider.value = colorizeVCColor.greenValue
        blueSlider.value = colorizeVCColor.blueValue
        
        redValueLabel.text = getRoundedStrValue(from: redSlider)
        greenValueLabel.text = getRoundedStrValue(from: greenSlider)
        blueValueLabel.text = getRoundedStrValue(from: blueSlider)
    }
    
    @IBAction func sliderIsMoved(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValueLabel.text = getRoundedStrValue(from: redSlider)
        case greenSlider:
            greenValueLabel.text = getRoundedStrValue(from: greenSlider)
        default:
            blueValueLabel.text = getRoundedStrValue(from: blueSlider)
        }
        
        colorizeView()
    }
    
    private func getRoundedStrValue(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func colorizeView() {
        colorPreview.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

extension UIColor {
    var redValue: Float { return Float(CIColor(color: self).red) }
    var greenValue: Float { return Float(CIColor(color: self).green) }
    var blueValue: Float { return Float(CIColor(color: self).blue) }
}
