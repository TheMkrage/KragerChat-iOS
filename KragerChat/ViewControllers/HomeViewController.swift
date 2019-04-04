//
//  HomeViewController.swift
//  KragerChat
//
//  Created by Matthew Krager on 3/6/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var shootingStarBackground: ShootingStarBackground = {
        let s = ShootingStarBackground()
        return s
    }()
    
    var earth: EarthView = {
        let e = EarthView()
        return e
    }()
    
    var moon: MoonView = {
        let m = MoonView()
        return m
    }()
    
    var nameTextField: KragerTextField = {
        let k = KragerTextField()
        return k
    }()
    var nameTextFieldHeightAnchor: NSLayoutConstraint!
    var nameTextFieldBottomAnchor: NSLayoutConstraint!
    
    var letsGoButton: KragerButton = {
        let b = KragerButton()
        b.setTitle("Let's Go!", for: .normal)
        return b
    }()
    var letsGoButtonHeightAnchor: NSLayoutConstraint!
    var letsGoButtonBottomAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(shootingStarBackground)
        view.addSubview(earth)
        view.addSubview(moon)
        view.addSubview(nameTextField)
        view.addSubview(letsGoButton)
        
        setupConstraints()
        view.layoutIfNeeded()
        animateSignInArea()
    }
    
    func setupConstraints() {
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalToConstant: 50)
        nameTextFieldHeightAnchor.isActive = true
        nameTextFieldBottomAnchor = nameTextField.bottomAnchor.constraint(equalTo: letsGoButton.topAnchor, constant: -15) // start offscreen with letsGoButton
        nameTextFieldBottomAnchor.isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        letsGoButtonHeightAnchor = letsGoButton.heightAnchor.constraint(equalToConstant: 50)
        letsGoButtonHeightAnchor.isActive = true
        letsGoButtonBottomAnchor = letsGoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 200) // start offscreen
        letsGoButtonBottomAnchor.isActive = true
        letsGoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        letsGoButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        moon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        moon.heightAnchor.constraint(equalToConstant: 20).isActive = true

        earth.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        earth.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -35).isActive = true
        earth.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40).isActive = true
        earth.heightAnchor.constraint(equalTo: earth.widthAnchor).isActive = true
        
        shootingStarBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shootingStarBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        shootingStarBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        shootingStarBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
