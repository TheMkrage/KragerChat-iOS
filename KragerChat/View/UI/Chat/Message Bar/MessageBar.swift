//
//  MessageBar.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/14/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

protocol MessageBarDelegate {
    func sent(message: String)
}

class MessageBar: UIView {
    
    var didSetConstraints = false
    
    var delegate: MessageBarDelegate?
    
    lazy var quoteButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "quote"), for: .normal)
        b.addTarget(self, action: #selector(quoteTapped), for: .touchUpInside)
        return b
    }()
    
    lazy var  photoButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(UIImage(named: "photo"), for: .normal)
        b.addTarget(self, action: #selector(photoTapped), for: .touchUpInside)
        return b
    }()
    
    let messageTextField: MessageTextField = {
        let m = MessageTextField()
        return m
    }()
    var bottomConstraint: NSLayoutConstraint!

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
        
        messageTextField.sendButton.addTarget(self, action: #selector(sendTapped(_:)), for: .touchUpInside)
        
        addSubview(quoteButton)
        addSubview(photoButton)
        addSubview(messageTextField)
    }
    
    // override to prevent premade constraints
    override var intrinsicContentSize: CGSize {
        let size = CGSize(width: UIScreen.main.bounds.width, height: 57.0)
        return size
    }
    
    override func resignFirstResponder() -> Bool {
        messageTextField.field.resignFirstResponder()
        return super.resignFirstResponder()
    }
    
    @objc func sendTapped(_ sender: UIButton) {
        delegate?.sent(message: messageTextField.text)
    }
    
    @objc func quoteTapped() {
        messageTextField.showQuoteKeyboard()
    }
    
    @objc func photoTapped() {
        messageTextField.showPhotoKeyboard()
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
        bottomConstraint = messageTextField.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -10)
        bottomConstraint.isActive = true
    }
}
