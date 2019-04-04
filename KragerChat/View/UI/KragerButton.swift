//
//  Button.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/4/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class KragerButton: UIButton {

    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.init(named: "buttonOutside")
        layer.borderColor = UIColor.init(named: "buttonOutside")?.cgColor
        layer.borderWidth = 3.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2.0
    }

}
