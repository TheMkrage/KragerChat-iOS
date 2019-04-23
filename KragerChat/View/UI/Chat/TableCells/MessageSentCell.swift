//
//  MessageSentCell.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/12/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class MessageSentCell: MessageCell {
    override public var bubbleColor: UIColor? { return UIColor.init(named: "sentMessage") }
    
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        bubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 45).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45
            ).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Draw the message tail
        let path = UIBezierPath()
        
        let A = CGPoint(x: bubbleView.frame.maxX, y: bubbleView.frame.maxY - bubbleCornerRadius)
        let B = CGPoint(x: bubbleView.frame.maxX + 13.0, y: bubbleView.frame.maxY + 9.0)
        let C = CGPoint(x: bubbleView.frame.maxX - 16.0, y: bubbleView.frame.maxY)
        
        path.move(to: A)
        path.addLine(to: B)
        path.addLine(to: C)
        path.close()
        
        bubbleColor?.setFill()
        
        path.fill()
    }
}
