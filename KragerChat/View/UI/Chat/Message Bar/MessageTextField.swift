//
//  MessageTextField.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/14/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class MessageTextField: UIView {
    
    var didSetConstraints = false

    var field: UITextField = {
        let f = UITextField()
        f.translatesAutoresizingMaskIntoConstraints = false
        f.borderStyle = .none
        return f
    }()
    
    var sendButton: UIButton = {
        let s = UIButton()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
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
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 7.0
        backgroundColor = .white
        
        addSubview(field)
        addSubview(sendButton)
    }
    
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        
        field.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        field.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10).isActive = true
        //field.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
    
        topAnchor.constraint(equalTo: field.topAnchor, constant: 5).isActive = true
        bottomAnchor.constraint(equalTo: field.bottomAnchor, constant: -5).isActive = true
    }
    
    private func showSendButton() {
        
    }
    
    private func hideSendButton() {
        
    }
}
