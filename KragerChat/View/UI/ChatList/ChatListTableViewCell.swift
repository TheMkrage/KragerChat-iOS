//
//  ChatListTableViewCell.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/19/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    
    var didSetConstraints = false
    
    var nameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
        return l
    }()
    
    var lastMessageLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "HelveticaNeue", size: 12.0)
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(lastMessageLabel)
        
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
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        
        lastMessageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0).isActive = true
        lastMessageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0).isActive = true
        lastMessageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
    }
}
