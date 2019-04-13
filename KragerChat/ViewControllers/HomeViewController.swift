//
//  HomeViewController.swift
//  KragerChat
//
//  Created by Matthew Krager on 3/6/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var kragerChatLogo: UIImageView = {
        let k = UIImageView(image: UIImage(named: "KragerChat"))
        k.translatesAutoresizingMaskIntoConstraints = false
        return k
    }()
    
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
    
    var letsGoButton: KragerButton = {
        let b = KragerButton()
        b.setTitle("Let's Go!", for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(shootingStarBackground)
        view.addSubview(kragerChatLogo)
        view.addSubview(earth)
        view.addSubview(moon)
        view.addSubview(nameTextField)
        view.addSubview(letsGoButton)
        
        setupConstraints()
        view.layoutIfNeeded()
        // animateSignInArea()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.animateFromBottom(superView: view)
        letsGoButton.animateFromBottom(superView: view)
    }
    
    func setupConstraints() {
        kragerChatLogo.heightAnchor.constraint(equalTo: kragerChatLogo.widthAnchor, multiplier: 0.419).isActive = true
        kragerChatLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        kragerChatLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        kragerChatLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: letsGoButton.topAnchor, constant: -15).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        letsGoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        letsGoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45).isActive = true
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
