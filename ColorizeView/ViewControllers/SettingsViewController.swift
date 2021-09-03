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
        }
    }

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var blueValue: UILabel!
    @IBOutlet var greenValue: UILabel!

    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!

    var colorizeVCColor: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()

        colorPreview.backgroundColor = colorizeVCColor

        redSlider.value = colorizeVCColor.redValue
        greenSlider.value = colorizeVCColor.greenValue
        blueSlider.value = colorizeVCColor.blueValue
    }
    
    @IBAction func sliderIsMoved(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValue.text = strValue(from: redSlider)
        case greenSlider:
            greenValue.text = strValue(from: greenSlider)
        default:
            blueValue.text = strValue(from: blueSlider)
        }
        
        colorizeView()
    }
    
    private func strValue(from slider: UISlider) -> String {
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
