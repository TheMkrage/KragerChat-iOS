//
//  QuoteTextView.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/23/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class QuoteTextView: UITextView {
    var didSetConstraints = false
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        textAlignment = .center
        isUserInteractionEnabled = false
        isScrollEnabled = false
        isEditable = false
        isSelectable = false
        textColor = .white
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
