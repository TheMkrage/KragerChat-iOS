//
//  KragerTextField.swift
//  KragerChat
//
//  Created by Matthew Krager on 3/6/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class KragerTextField: UITextField {
    
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
        backgroundColor = UIColor(named: "textFieldFill")
        textAlignment = .center
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2.0
    }

}
