//
//  SettingsViewController.swift
//  ColorizeView
//
//  Created by Igor on 03.09.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: -  IBOUtlets

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
    
    // MARK: - Public properties
    
    var colorizeVCColor: UIColor!
    var delegate: SettingsViewControllerDelegate!

    // MARK: - Life cycle methods

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
        
        redValueField.delegate = self
        greenValueField.delegate = self
        blueValueField.delegate = self
        
        addToolbarOnTextfield(for: redValueField, greenValueField, blueValueField)
    }
    
    // MARK: - IBActions
    
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
        
        colorizePreview()
    }
    
    @IBAction func doneBtnPressed() {
        guard let previewColor = previewView.backgroundColor else { return }
        
        delegate.setNewUIColor(for: previewColor)
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func getRoundedStrValue(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func colorizePreview() {
        previewView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

// MARK: - UIColor chenels values return

extension UIColor {
    var redValue: Float { Float(CIColor(color: self).red) }
    var greenValue: Float { Float(CIColor(color: self).green) }
    var blueValue: Float { Float(CIColor(color: self).blue) }
}

// MARK: - Keyboard solutions

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldText = textField.text else { return }

        switch textField {
        case redValueField:
            guard let value = Float(textFieldText) else {
                textField.text = redValueLabel.text
                return
            }
            
            redSlider.value = value
            redValueLabel.text = getRoundedStrValue(from: redSlider)
            textField.text = redValueLabel.text
        case greenValueField:
            guard let value = Float(textFieldText) else {
                textField.text = greenValueLabel.text
                return
            }
            
            greenSlider.value = value
            greenValueLabel.text = getRoundedStrValue(from: greenSlider)
            textField.text = greenValueLabel.text
        default:
            guard let value = Float(textFieldText) else {
                textField.text = blueValueLabel.text
                return
            }
            
            blueSlider.value = value
            blueValueLabel.text = getRoundedStrValue(from: blueSlider)
            textField.text = blueValueLabel.text
        }
        
        colorizePreview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func addToolbarOnTextfield(for textfields: UITextField...) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        
        toolbar.items = [space, doneBtn]
        toolbar.sizeToFit()
        
        for textfield in textfields {
            textfield.inputAccessoryView = toolbar
        }
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}
