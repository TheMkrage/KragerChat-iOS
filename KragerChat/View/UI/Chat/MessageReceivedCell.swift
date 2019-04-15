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
