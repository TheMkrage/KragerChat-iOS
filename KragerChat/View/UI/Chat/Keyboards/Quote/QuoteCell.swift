//
//  QuoteCell.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/21/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class QuoteCell: UICollectionViewCell {
    var didSetConstraints = false
    public var bubbleColor: UIColor? { return .yellow }
    
    var quoteLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.setContentCompressionResistancePriority(.required, for: .vertical)
        l.text = "This is a cool message lol"
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        
        contentView.addSubview(quoteLabel)
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        didSetConstraints = true
        
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4).isActive = true
        
        
        let padding: CGFloat = 7.5
        quoteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        quoteLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        quoteLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
    }
}
