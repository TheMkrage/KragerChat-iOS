//
//  HomeViewController+Animations.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/4/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

extension HomeViewController {
    func animateSignInArea() {
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.letsGoButtonBottomAnchor.constant = -45
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            print(isFinished)
        }
    }
}
