//
//  UIViewController+Extension.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/18/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
       
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
    }
    
    func subscribeToKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
