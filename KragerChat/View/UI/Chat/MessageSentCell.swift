//
//  MessageSentCell.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/12/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class MessageSentCell: UITableViewCell {
    
    var didSetConstraints = false
    
    var bubbleView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.init(named: "sentMessage")
        v.layer.cornerRadius = 7
        return v
    }()
    
    var messageLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.numberOfLines = 0
        l.text = "This is a cool message lol"
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
        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        
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
        bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 45).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45).isActive = true
        
        let messagePadding: CGFloat = 12
        messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: messagePadding).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -messagePadding).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: messagePadding).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -messagePadding).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // draw the tail
    }
}
