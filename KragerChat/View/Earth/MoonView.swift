//
//  MoonView.swift
//  KragerChat
//
//  Created by Matthew Krager on 3/8/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class MoonView: UIView {

    var imageView = UIImageView(image: UIImage.init(named: "Moon"))
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        beginSpin()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    func beginSpin() {
        let spinAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        let pi = Double.pi
        
        let ease = CAMediaTimingFunction.init(name: .easeInEaseOut)
        spinAnimation.timingFunctions = [ease, ease, ease, ease, ease]
        spinAnimation.repeatCount = .infinity
        spinAnimation.values = [0, pi * 16, -pi, pi * 3, -pi * 8]
        spinAnimation.keyTimes = [0, 0.3, 0.5, 0.7, 1]
        spinAnimation.duration = 20.0
        spinAnimation.isAdditive = true
        
        imageView.layer.add(spinAnimation, forKey: "spin")
    }

}
