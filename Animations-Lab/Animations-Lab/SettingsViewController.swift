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
           
    lazy var userFeedbackLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
   
    lazy var animationTimeStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 10.0
        stepper.minimumValue = 0.0
        stepper.stepValue = 0.5
        stepper.addTarget(self, action: #selector(animationTimerStepperChanged), for: .valueChanged)
        return stepper
    }()
    
    lazy var movementDistanceStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 250
        stepper.minimumValue = 50.0
        stepper.stepValue = 10
        stepper.addTarget(self, action: #selector(movementDistanceStepperChanged), for: .valueChanged)
        return stepper
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()
    
    let components = ["Autoreverse", "TransitionFlipFromLeft", "CurveLinear", "TransitionFlipFromTop", "TransitionCrossDissolve"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstrainsts()
        delegatesAndDatasources()
        loadUI()
        view.backgroundColor = .systemBackground
    }
    
    @objc private func animationTimerStepperChanged(){
        UserDefaults.standard.set(animationTimeStepper.value, forKey: UserDefaultsKeys.animationTime)
        updateUI()
    }
    
    @objc private func movementDistanceStepperChanged(){
        UserDefaults.standard.set(movementDistanceStepper.value, forKey: UserDefaultsKeys.animationDistance)
        updateUI()
    }
   
    private func loadUI(){
        if let savedTimeStepperValue = UserDefaults.standard.object(forKey: UserDefaultsKeys.animationTime) as? Double{
            animationTimeStepper.value = savedTimeStepperValue
        } 

        if let savedOption = UserDefaults.standard.object(forKey: UserDefaultsKeys.animationOption) as? Int{
            pickerView.selectRow(savedOption, inComponent: 0, animated: true)
        }

        if let savedDistanceValue = UserDefaults.standard.object(forKey: UserDefaultsKeys.animationDistance) as? Double{
            movementDistanceStepper.value = savedDistanceValue
        }
        
        updateUI()
    }
    
    private func updateUI(){
        userFeedbackLabel.text = "Animation Time: \(animationTimeStepper.value)\nAnimation Distance: \(movementDistanceStepper.value)\nAnimation Option: \(components[pickerView.selectedRow(inComponent: 0)])"
    }
    
    private func delegatesAndDatasources(){
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func configureConstrainsts(){
        configureUserFeedBackLabel()
        configureStackView()
        configurePickerView()
    }
    
    private func configureUserFeedBackLabel(){
        view.addSubview(userFeedbackLabel)
        userFeedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userFeedbackLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            userFeedbackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userFeedbackLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func configureStackView(){
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(animationTimeStepper)
        stackView.addArrangedSubview(movementDistanceStepper)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: userFeedbackLabel.bottomAnchor, constant: 8),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            stackView.centerXAnchor.constraint(equalTo: userFeedbackLabel.centerXAnchor)
        ])
    }
    
    private func configurePickerView(){
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            pickerView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            pickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
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
        return components[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateUI()
        UserDefaults.standard.set(row, forKey: UserDefaultsKeys.animationOption)
    }
}
