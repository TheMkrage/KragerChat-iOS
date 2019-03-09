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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(shootingStarBackground)
        view.addSubview(earth)
        
        setupConstraints()
    }
    
    func setupConstraints() {
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
