//
//  UIView+Extensions.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/4/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

extension UIView {
    func animateFromBottom(superView: UIView) {
        let distanceBelowToOffscreen = UIScreen.main.bounds.maxY - frame.minY + frame.height
        transform = CGAffineTransform(translationX: 0, y: distanceBelowToOffscreen)
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.transform = CGAffineTransform.identity
        }) { (isFinished) in
            print(isFinished)
        }
    }
}
