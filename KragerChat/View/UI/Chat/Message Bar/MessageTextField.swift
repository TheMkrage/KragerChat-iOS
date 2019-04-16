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

    lazy var field: UITextView = {
        let f = UITextView()
        f.translatesAutoresizingMaskIntoConstraints = false
        f.font = UIFont(name: "HelveticaNeue", size: 15.0)
        f.isScrollEnabled = false
        f.delegate = self
        return f
    }()
    
    var sendButton: UIButton = {
        let s = UIButton()
        s.setImage(UIImage.init(named: "sendButton"), for: .normal)
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
        field.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0).isActive = true
        field.topAnchor.constraint(equalTo: topAnchor).isActive = true
        field.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 26.0).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 26.0).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
    }
    
    private func showSendButton() {
        let pi = Double.pi
        
        sendButton.transform = CGAffineTransform(rotationAngle: CGFloat(pi/2.0))
        sendButton.transform = CGAffineTransform(scaleX: 0.3, y: 1.0)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.sendButton.transform = CGAffineTransform.identity
        }
        
        let spinAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        spinAnimation.timingFunction = CAMediaTimingFunction.init(name: .linear)
        spinAnimation.duration = 0.25
        spinAnimation.fromValue = CGFloat(pi)
        spinAnimation.toValue = 0.0
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.25
        scaleAnimation.fromValue = 0.3
        scaleAnimation.toValue = 1.0
        
        sendButton.layer.add(scaleAnimation, forKey: "scale")
        sendButton.layer.add(spinAnimation, forKey: "spin")
        CATransaction.commit()
    }
    
    private func hideSendButton() {
        
    }
}

extension MessageTextField: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            hideSendButton()
        } else {
            showSendButton()
        }
    }
}
