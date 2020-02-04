//
//  SettingsViewController.swift
//  Animations-Lab
//
//  Created by Bienbenido Angeles on 2/3/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

struct UserDefaultsKeys {
    static let animationTime = "Animation Time"
    static let animationDistance = "Animation Distance"
    static let animationOption = "Animation Options"
}

enum AnimationOptions {
    typealias RawValue = Int
    
    case autoReverse(String)
    case transitionFlipFromLeft(String)
    case curveLinear(String)
    case transitionFlipFromTop(String)
    case transitionCrossDissolve(String)
}

class SettingsViewController: UIViewController {
           
   lazy var animationTimeStepper: UIStepper = {
       let stepper = UIStepper()
       stepper.maximumValue = 10.0
       stepper.minimumValue = 0.0
       stepper.stepValue = 0.5
    stepper.addTarget(self, action: #selector(animationTimerStepperChanged), for: .valueChanged)
       return stepper
   }()
    
    lazy var userFeedbackLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    lazy var movementDistanceStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 200
        stepper.minimumValue = 10.0
        stepper.stepValue = 10
        stepper.addTarget(self, action: #selector(movementDistanceStepperChanged), for: .valueChanged)
        return stepper
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    var components = ["Autoreverse", "TransitionFlipFromLeft", "CurveLinear", "TransitionFlipFromTop", "TransitionCrossDissolve"]

    override func viewDidLoad() {
        super.viewDidLoad()
        delegatesAndDatasources()
        updateUI()
    }
    
    @objc private func animationTimerStepperChanged(){
        UserDefaults.standard.set(animationTimeStepper.value, forKey: UserDefaultsKeys.animationTime)
        updateUI()
    }
    
    @objc private func movementDistanceStepperChanged(){
        UserDefaults.standard.set(movementDistanceStepper.value, forKey: UserDefaultsKeys.animationDistance)
        updateUI()
    }
   
    private func updateUI() {
        
        
        if let savedTimeStepperValue = UserDefaults.standard.object(forKey: UserDefaultsKeys.animationTime) as? Double{
            animationTimeStepper.value = savedTimeStepperValue
        }
        
        if let savedOption = UserDefaults.standard.object(forKey: UserDefaultsKeys.animationOption) as? Int{
            pickerView.selectRow(savedOption, inComponent: savedOption, animated: true)
        }
        
        if let savedDistanceValue = UserDefaults.standard.object(forKey: UserDefaultsKeys.animationDistance) as? Double{
            movementDistanceStepper.value = savedDistanceValue
        }
        
        userFeedbackLabel.text = "Animation Time: \(animationTimeStepper.value)\nAnimation Distance: \(movementDistanceStepper.value)\nAnimation Option: \(components[pickerView.selectedRow(inComponent: 0)])"
        
    }
    
    private func delegatesAndDatasources(){
        pickerView.delegate = self
        pickerView.dataSource = self
    }

}

extension SettingsViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components.count
    }
}

extension SettingsViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return components[component]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(row, forKey: UserDefaultsKeys.animationOption)
    }
}
