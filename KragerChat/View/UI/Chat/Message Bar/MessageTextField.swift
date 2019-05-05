//
//  MessageTextField.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/14/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

enum KeyboardState {
    case none, message, quote, photo
}

class MessageTextField: UIView {
    
    var didSetConstraints = false
    var keyboardState: KeyboardState = .none {
        didSet {
            // don't refresh if keyboardState did not change
            if keyboardState == oldValue {
                return
            }
            switch keyboardState {
            case .message, .none:
                field.inputView = nil
            case .photo:
                field.inputView = photoKeyboard
            case .quote:
                field.inputView = quoteKeyboard
            }
            field.resignFirstResponder()
            field.reloadInputViews()
            field.becomeFirstResponder()
            
            // update the cursor
            if keyboardState == .none || keyboardState == .message {
                field.tintColor = UIColor(named: "sentMessage")!
            } else {
                field.tintColor = .clear
            }
        }
    }

    lazy var field: UITextView = {
        let f = UITextView()
        f.translatesAutoresizingMaskIntoConstraints = false
        f.font = UIFont(name: "HelveticaNeue", size: 15.0)
        f.isScrollEnabled = false
        f.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(fieldTapped))
        f.addGestureRecognizer(tapRecognizer)
        return f
    }()
    
    lazy var quoteKeyboard: QuoteKeyboard = {
        let x = QuoteKeyboard()
        x.delegate = self
        return x
    }()
    
    lazy var photoKeyboard: PhotoKeyboard = {
        let x = PhotoKeyboard()
        x.delegate = self
        return x
    }()
    
    var sendButton: SendButton = {
        let s = SendButton()
        s.isHidden = true
        return s
    }()
    
    var text: String {
        get {
            return field.text
        }
    }
    
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
    
    @objc private func fieldTapped() {
        keyboardState = .message
    }
    
    func quoteButtonPressed() {
        if keyboardState != .quote {
            keyboardState = .quote
        } else {
            keyboardState = .message
        }
    }
    
    func showPhotoKeyboard() {
        if keyboardState != .photo {
            keyboardState = .photo
        } else {
            keyboardState = .message
        }
    }
}

extension MessageTextField: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            sendButton.hide()
        } else {
            sendButton.show()
        }
    }
}

extension MessageTextField: QuoteKeyboardDelegate {
    func selected(quote: String) {
        field.text = quote
        sendButton.show()
    }
}

extension MessageTextField: PhotoKeyboardDelegate {
    func selected(photo: Photo) {
        let attachment = NSTextAttachment()
        attachment.image = photo.image
        
        // scale the photo
        let oldWidth = attachment.image!.size.width;
        let scaleFactor = oldWidth / (field.frame.size.width - 10)
        guard let cgImage = attachment.image!.cgImage else {
            return
        }
        attachment.image = UIImage(cgImage: cgImage, scale: scaleFactor, orientation: .up)
        
        let attrStringWithImage = NSAttributedString(attachment: attachment)
        field.attributedText = attrStringWithImage
        sendButton.show()
    }
}
