//
//  ChatViewController.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/12/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

enum ChatKeyboardState {
    case none, message, quote, photo
}

class ChatViewController: UIViewController {
    
    var chatViewModel = ChatViewModel()
    var keyboardState: ChatKeyboardState = .none
    
    lazy var messageBar: MessageBar =  {
        let m = MessageBar()
        m.delegate = self
        return m
    }()
    
    lazy var chatView: ChatView = {
        chatViewModel.messages.append(Message(message: "Hey there!", didUserSend: true))
        chatViewModel.messages.append(Message(message: "This is Krager Chat!", didUserSend: false, sender: "Krager"))
        chatViewModel.messages.append(Message(message: "OMG! This app is so cool and way better than Ishaan Chat, Why? Because Ishaan chat doesnt and will never exist", didUserSend: true))
        let c = ChatView(viewModel: chatViewModel)
        return c
    }()
    
    let quoteKeyboard: QuoteKeyboard = {
        let x = QuoteKeyboard()
        return x
    }()
    
    let photoKeyboard: PhotoKeyboard = {
        let x = PhotoKeyboard()
        return x
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(named: "bg")
        view.addSubview(chatView)
        
        setupConstraints()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboard()
    }
    
    override var inputAccessoryView: UIView? {
        return messageBar
    }
    
    override var inputView: UIView? {
        switch keyboardState {
        case .none, .message:
            return nil
        case .quote:
            return quoteKeyboard
        case .photo:
            return photoKeyboard
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private func setupConstraints() {
        chatView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        chatView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        chatView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        chatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: Keyboard Management
    // Reshape the tableview based on the keyboard's appearance
    override func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            chatView.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        }
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        chatView.tableView.contentInset = .zero
    }
    
    private func showQuoteKeyboard() {
        messageBar.resignFirstResponder()

        keyboardState = .quote
        becomeFirstResponder()
        reloadInputViews()
    }
    
    private func showPhotoKeyboard() {
        keyboardState = .photo
        reloadInputViews()
    }
}

extension ChatViewController: MessageBarDelegate {
    func sent(message: String) {
        chatViewModel.messages.append(Message(message: message, didUserSend: true))
        chatView.tableView.reloadData()
        chatView.tableView.scrollToRow(at: IndexPath(row: chatViewModel.messages.count - 1, section: 0), at: .bottom, animated: true)
        messageBar.messageTextField.field.text = ""
    }
    
    func quoteButtonTapped() {
        showQuoteKeyboard()
    }
    
    func photoButtonTapped() {
        showPhotoKeyboard()
    }
}
