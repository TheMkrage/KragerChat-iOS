//
//  PhotoKeyboard.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/21/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class PhotoKeyboard: Keyboard {

    var didSetConstraints = false
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .blue
    }
    
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        didSetConstraints = true
        
    }
}
