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
    
    var quoteTextView: QuoteTextView = {
        let l = QuoteTextView()
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
        contentView.autoresizingMask = [.flexibleHeight]
        backgroundColor = .clear
        
        contentView.addSubview(quoteTextView)
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    static let padding: CGFloat = 7.5
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        didSetConstraints = true
        
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: QuoteCell.padding * 2.0).isActive = true
        
        quoteTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: QuoteCell.padding).isActive = true
        let trailingPaddingConstraint = quoteTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -QuoteCell.padding)
        trailingPaddingConstraint.priority = UILayoutPriority(rawValue: 999)
        trailingPaddingConstraint.isActive = true
        quoteTextView.topAnchor.constraint(equalTo: topAnchor, constant: QuoteCell.padding).isActive = true
        let bottomPaddingConstraint = quoteTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -QuoteCell.padding)
        bottomPaddingConstraint.priority = UILayoutPriority(rawValue: 999)
        bottomPaddingConstraint.isActive = true
    }
}
