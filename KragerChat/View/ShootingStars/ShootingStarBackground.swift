//
//  ShootingStarBackground.swift
//  KragerChat
//
//  Created by Matthew Krager on 3/7/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class ShootingStarBackground: UIView {
    
    var stars = [Star]()
    var planets = [Planet]()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.init(named: "bg")
        
        beginAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAnimation() {
        let starWidth = 57
        let starHeight = 30
        let animationDuration = 0.5
        // add Stars
        for _ in 0..<10 {
            let startingHeight = Int.random(in: 100..<Int(UIScreen.main.bounds.maxY) - starHeight)
            let star = Star.init(frame: CGRect(x: -starWidth, y: startingHeight, width: starWidth, height: starHeight))
            stars.append(star)
            addSubview(star)
            let delay = Double.random(in: 0..<animationDuration)
            UIView.animate(withDuration: animationDuration, delay: delay, options: [.repeat, .curveLinear], animations: {
                star.frame = CGRect(x: Int(UIScreen.main.bounds.maxX) + starWidth, y: startingHeight + starHeight, width: starWidth, height: starHeight)
            }, completion: nil)
        }
    }
}
