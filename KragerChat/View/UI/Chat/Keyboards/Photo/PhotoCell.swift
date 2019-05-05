//
//  PhotoCell.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/4/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    var didSetConstraints = false
    
    var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        return i
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
        layer.cornerRadius = 8.0
        clipsToBounds = true
        
        contentView.addSubview(imageView)
        
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
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: PhotoCell.padding * 2.0).isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PhotoCell.padding).isActive = true
        let trailingPaddingConstraint = imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -PhotoCell.padding)
        trailingPaddingConstraint.priority = UILayoutPriority(rawValue: 999)
        trailingPaddingConstraint.isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: PhotoCell.padding).isActive = true
        let bottomPaddingConstraint = imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -PhotoCell.padding)
        bottomPaddingConstraint.priority = UILayoutPriority(rawValue: 999)
        bottomPaddingConstraint.isActive = true
    }
}
