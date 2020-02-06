//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 30
        return buttonStack
    }()
    
    lazy var upButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var leftButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareLeft(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square right", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareRight(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        configureConstraints()
        addBarButtonItems()
        loadInSettingsValues()
    }
    
    private func addBarButtonItems(){
        let saveBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(navigateToSettingsButton))
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    @objc
    private func navigateToSettingsButton(){
        let settingsVC = SettingsViewController()
        settingsVC.delegate = self
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - animationDistance
        
        UIView.transition(with: blueSquare, duration: animationDuration, options: animationOption, animations: {
            [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffet = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffet + animationDistance
        UIView.transition(with: blueSquare, duration: animationDuration, options: animationOption, animations: {
            [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @IBAction func animateSquareLeft(sender: UIButton) {
        let oldOffet = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffet - animationDistance
        UIView.transition(with: blueSquare, duration: animationDuration, options: animationOption, animations: {
            [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @IBAction func animateSquareRight(sender: UIButton) {
        let oldOffet = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffet + animationDistance
        
        UIView.transition(with: blueSquare, duration: animationDuration, options: animationOption, animations: {
            [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: nil)

    }
    
    var animationDuration: Double = 1
    var animationDistance:CGFloat = 150
    var animationOptions:[UIView.AnimationOptions] = [.autoreverse, .transitionFlipFromLeft, .curveLinear, .transitionFlipFromTop, .transitionCrossDissolve]
    var animationOption:UIView.AnimationOptions!
    
    private func loadInSettingsValues(){
        if let animationDuration = UserDefaults.standard.object(forKey: UserDefaultsKeys.animationTime) as? Double{
            self.animationDuration = animationDuration
        }
        
        if let animationDistance = UserDefaults.standard.object(forKey: UserDefaultsKeys.animationDistance) as? Double{
            self.animationDistance = CGFloat(animationDistance)
        }
        
        if let animationOption = UserDefaults.standard.object(forKey: UserDefaultsKeys.animationOption) as? Int{
            self.animationOption = animationOptions[animationOption]
        }
    }
    
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonStackView)
    }
    
    private func addStackViewSubviews() {
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
        buttonStackView.addSubview(leftButton)
        buttonStackView.addSubview(rightButton)
    }
    
    private func configureConstraints() {
        constrainBlueSquare()
        constrainDownButton()
        constrainUpButton()
        constrainRightButton()
        constraintLeftButton()
        constrainButtonStackView()
    }
    
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
        upButton.topAnchor.constraint(equalTo: buttonStackView.topAnchor).isActive = true
    }
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        downButton.topAnchor.constraint(equalTo: buttonStackView.topAnchor).isActive = true
        downButton.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor).isActive = true
    }
    
    private func constraintLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftButton.heightAnchor.constraint(equalToConstant: 50),
            leftButton.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor),
            leftButton.topAnchor.constraint(equalTo: downButton.bottomAnchor, constant: 8),
            leftButton.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            //leftButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func constrainRightButton(){
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightButton.heightAnchor.constraint(equalToConstant: 50),
            rightButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor),
            rightButton.topAnchor.constraint(equalTo: upButton.bottomAnchor, constant: 8),
            rightButton.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            //rightButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    
    private func constrainButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 108),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}

extension ViewController: Settings{
    func applySettings(animationTime: Double, animationDistance: Double, animationOption: Int) {
        self.animationDuration = animationTime
        self.animationDistance = CGFloat(animationDistance)
        self.animationOption = animationOptions[animationOption]
    }
}
