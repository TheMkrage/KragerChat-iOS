//
//  MessageBar.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/14/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class MessageBar: UIView {
    
    var didSetConstraints = false
    
    let quoteButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "quote"), for: .normal)
        return b
    }()
    
    let photoButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "photo"), for: .normal)
        return b
    }()
    
    let messageTextField: MessageTextField = {
        let m = MessageTextField()
        return m
    }()

    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        autoresizingMask = .flexibleHeight
        
        addSubview(quoteButton)
        addSubview(photoButton)
        addSubview(messageTextField)
    }
    
    // override to prevent premade constraints
    override var intrinsicContentSize: CGSize {
        let size = CGSize(width: UIScreen.main.bounds.width, height: 57.0)
        return size
    }
    
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        quoteButton.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        quoteButton.heightAnchor.constraint(equalToConstant: 21.0).isActive = true
        quoteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0).isActive = true
        quoteButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor).isActive = true
        
        photoButton.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        photoButton.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        photoButton.leadingAnchor.constraint(equalTo: quoteButton.trailingAnchor, constant: 20.0).isActive = true
        photoButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor).isActive = true
        
        messageTextField.leadingAnchor.constraint(equalTo: photoButton.trailingAnchor, constant: 20).isActive = true
        messageTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        
        topAnchor.constraint(equalTo: messageTextField.topAnchor, constant: -5).isActive = true
        messageTextField.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
    }
}
