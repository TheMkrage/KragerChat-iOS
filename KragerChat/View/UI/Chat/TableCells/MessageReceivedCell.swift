//
//  MessageReceivedCell.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/14/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class MessageReceivedCell: MessageCell {
    override public var bubbleColor: UIColor? { return UIColor.init(named: "receivedMessage") }
    
    var nameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont(name: "HelveticaNeue-Bold", size: 11.0)
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
        
    }
    
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        
        bubbleView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -45).isActive = true
        bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45
            ).isActive = true
        
        contentView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bubbleView.topAnchor, constant: -3).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Draw the message tail
        let path = UIBezierPath()
        
        let A = CGPoint(x: bubbleView.frame.minX, y: bubbleView.frame.maxY - bubbleCornerRadius)
        let B = CGPoint(x: bubbleView.frame.minX - 13.0, y: bubbleView.frame.maxY + 9.0)
        let C = CGPoint(x: bubbleView.frame.minX + 16.0, y: bubbleView.frame.maxY)
        
        path.move(to: A)
        path.addLine(to: B)
        path.addLine(to: C)
        path.close()
        
        bubbleColor?.setFill()
        
        path.fill()
    }
}
