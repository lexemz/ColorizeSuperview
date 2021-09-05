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
            previewView.backgroundColor = colorizeVCSuperViewColor
        }
    }

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!

    @IBOutlet var redValueTF: UITextField!
    @IBOutlet var greenValueTF: UITextField!
    @IBOutlet var blueValueTF: UITextField!
    
    // MARK: - Public properties
    
    var colorizeVCSuperViewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!

    // MARK: - Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.value = Float(CIColor(color: colorizeVCSuperViewColor).red)
        greenSlider.value = Float(CIColor(color: colorizeVCSuperViewColor).green)
        blueSlider.value = Float(CIColor(color: colorizeVCSuperViewColor).blue)
        
        redValueLabel.text = getRoundedStrValue(from: redSlider)
        greenValueLabel.text = getRoundedStrValue(from: greenSlider)
        blueValueLabel.text = getRoundedStrValue(from: blueSlider)
        
        redValueTF.text = redValueLabel.text
        greenValueTF.text = greenValueLabel.text
        blueValueTF.text = blueValueLabel.text
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        addToolbarOnTextfield(for: redValueTF, greenValueTF, blueValueTF)
    }
    
    // MARK: - IBActions
    
    @IBAction func sliderIsMoved(_ sender: UISlider) {
        switch sender {
        case redSlider:
            let redRoundedValue = getRoundedStrValue(from: redSlider)
            
            redValueLabel.text = redRoundedValue
            redValueTF.text = redRoundedValue
            
        case greenSlider:
            let greenRoundedValue = getRoundedStrValue(from: greenSlider)
            
            greenValueLabel.text = greenRoundedValue
            greenValueTF.text = greenRoundedValue
            
        default:
            let blueRoundedValue = getRoundedStrValue(from: blueSlider)
            
            blueValueLabel.text = blueRoundedValue
            blueValueTF.text = blueRoundedValue
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

// MARK: - Keyboard solutions

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldText = textField.text else { return }

        switch textField {
        case redValueTF:
            guard let value = Float(textFieldText) else {
                textField.text = redValueLabel.text
                return
            }
            
            redSlider.value = value
            redValueLabel.text = getRoundedStrValue(from: redSlider)
            textField.text = redValueLabel.text
        case greenValueTF:
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
    
    private func addToolbarOnTextfield(for textfields: UITextField...) {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        let nextBtn = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapNext))
        let prevBtn = UIBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(didTapPrev))
        
        toolbar.items = [prevBtn, nextBtn, space, doneBtn]
        toolbar.sizeToFit()
        
        for textfield in textfields {
            textfield.inputAccessoryView = toolbar
        }
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    @objc private func didTapNext() {
        if redValueTF.isFirstResponder {
            greenValueTF.becomeFirstResponder()
        } else if greenValueTF.isFirstResponder {
            blueValueTF.becomeFirstResponder()
        }
    }
    
    @objc private func didTapPrev() {
        if blueValueTF.isFirstResponder {
            greenValueTF.becomeFirstResponder()
        } else if greenValueTF.isFirstResponder {
            redValueTF.becomeFirstResponder()
        }
    }
}
