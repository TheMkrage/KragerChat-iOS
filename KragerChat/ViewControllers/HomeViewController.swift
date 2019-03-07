//
//  HomeViewController.swift
//  KragerChat
//
//  Created by Matthew Krager on 3/6/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var earth: EarthView = {
        let e = EarthView()
        return e
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 22.0/255.0, green: 21.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        view.addSubview(earth)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        earth.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        earth.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -35).isActive = true
        earth.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40).isActive = true
        earth.heightAnchor.constraint(equalTo: earth.widthAnchor).isActive = true
    }
}
