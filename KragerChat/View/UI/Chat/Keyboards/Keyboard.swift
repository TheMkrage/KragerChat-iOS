//
//  Keyboard.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/21/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class Keyboard: UIView {
    
    var heightConstraint: NSLayoutConstraint!

    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = false
    }
}
