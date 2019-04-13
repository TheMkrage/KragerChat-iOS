//
//  EarthView.swift
//  KragerChat
//
//  Created by Matthew Krager on 3/6/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class EarthView: UIView {
    
    var imageView = UIImageView(image: UIImage.init(named: "Earth"))
    
    var moon: MoonView = {
        let m = MoonView()
        m.widthAnchor.constraint(equalToConstant: 30).isActive = true
        m.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return m
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = false
        imageView.layer.shadowOpacity = 1.0
        imageView.layer.shadowRadius = 20.0
        imageView.layer.shadowColor = UIColor.yellow.cgColor
        addSubview(moon)
        addSubview(imageView)
        beginSpin()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        animateMoon()
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
    
    func animateMoon() {
        let orbitRadius: CGFloat = 165.0
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            // Begin moon orbit once previous block is complete
            let orbit = CAKeyframeAnimation(keyPath: "position")
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.midX, y: self.bounds.midY), radius: orbitRadius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            orbit.path = circlePath.cgPath
            orbit.duration = 2.5
            orbit.repeatCount = .infinity
            orbit.calculationMode = CAAnimationCalculationMode.paced
            orbit.rotationMode = CAAnimationRotationMode.rotateAuto
            
            self.moon.layer.add(orbit, forKey: "orbit")
        }
        
        let intro = CAKeyframeAnimation(keyPath: "position")
        let introPath = UIBezierPath()
        introPath.move(to: CGPoint(x: -frame.minX, y: -frame.minY))
        let endingPoint = CGPoint(x: bounds.midX + orbitRadius, y: bounds.midY)
        let control = CGPoint(x: bounds.maxX, y: bounds.minY - orbitRadius * 2.5)
        introPath.addQuadCurve(to: endingPoint, controlPoint: control)
        
        intro.path = introPath.cgPath
        intro.duration = 1.5
        moon.layer.add(intro, forKey: "intro")
        
        CATransaction.commit()
    }
}
