//
//  swift
//  KragerChat
//
//  Created by Matthew Krager on 4/17/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class SendButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        setImage(UIImage.init(named: "sendButton"), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func show() {
        // if the button is already visible, do not reanimate
        guard isHidden else {
            return
        }
        isHidden = false
        // if view is animating, do not start another animation
        let pi = Double.pi
        
        CATransaction.begin()
        
        let spinAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        spinAnimation.timingFunction = CAMediaTimingFunction.init(name: .linear)
        spinAnimation.duration = 0.25
        spinAnimation.fromValue = CGFloat(pi)
        spinAnimation.toValue = 0.0
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.25
        scaleAnimation.fromValue = 0.3
        scaleAnimation.toValue = 1.0
        
        layer.add(scaleAnimation, forKey: "scale")
        layer.add(spinAnimation, forKey: "spin")
        CATransaction.commit()
    }
    
    func hide() {
        // if the button is not visible, do not reanimate disapearance
        guard !isHidden else {
            return
        }
        
        let pi = Double.pi
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.isHidden = true
        }
        
        let spinAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        spinAnimation.timingFunction = CAMediaTimingFunction.init(name: .linear)
        spinAnimation.duration = 0.25
        spinAnimation.fromValue = 0.0
        spinAnimation.toValue = CGFloat(pi)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.25
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 0.3
        
        layer.add(scaleAnimation, forKey: "scale")
        layer.add(spinAnimation, forKey: "spin")
        CATransaction.commit()
    }

}
