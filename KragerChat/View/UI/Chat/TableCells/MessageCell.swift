//
//  MessageCell.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/14/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class MessageImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = MessageCell.imageWidth
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        return CGSize(width: -1.0, height: -1.0)
    }
}

class MessageCell: UITableViewCell {
    
    static let messagePadding: CGFloat = 12
    static let imageWidth = UIScreen.main.bounds.width  - ((45 * 2) + (messagePadding * 2))

    var didSetConstraints = false
    public var bubbleColor: UIColor? { return .black }
    
    let bubbleCornerRadius: CGFloat = 7.0
    lazy var bubbleView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = bubbleColor
        v.layer.cornerRadius = bubbleCornerRadius
        return v
    }()
    
    var messageLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.numberOfLines = 0
        return l
    }()
    
    var photoView: MessageImageView = {
        let i = MessageImageView()
        //i.contentMode = .scaleAspectFit
        i.translatesAutoresizingMaskIntoConstraints = false
        i.clipsToBounds = true
        return i
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
        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        bubbleView.addSubview(photoView)
        
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
        
        let messagePadding: CGFloat = MessageCell.messagePadding
        messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: messagePadding).isActive = true
        let bottomPadding = messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -messagePadding)
        bottomPadding.priority = .init(rawValue: 999)
        bottomPadding.isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: messagePadding).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -messagePadding).isActive = true
        
        photoView.widthAnchor.constraint(lessThanOrEqualToConstant: MessageCell.imageWidth).isActive = true
        photoView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: messagePadding).isActive = true
        let bottomPhotoPadding = photoView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -messagePadding)
        bottomPhotoPadding.priority = .init(rawValue: 999)
        bottomPhotoPadding.isActive = true
        photoView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: messagePadding).isActive = true
        photoView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -messagePadding).isActive = true
    }
}
