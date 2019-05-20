//
//  ChatViewController.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/12/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    var chatViewModel = ChatViewModel()
    var threadID: Int
    
    var client: ChatClient = {
        let c = ChatClient()
        return c
    }()
    
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
    
    init(threadID: Int) {
        self.threadID = threadID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        client.delegate = self

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
}

extension ChatViewController: MessageBarDelegate {
    func sent(message: String, photo: Photo?) {
        // if photo exists, send it first in separate message
        // send photo if it exists
        if let photo = photo {
            let m = Message(photo: photo, didUserSend: true)
            chatViewModel.messages.append(m)
            client.send(message: m)
        }
        // send message if it exists
        if message != "" {
            let m = Message(message: message, didUserSend: true)
            chatViewModel.messages.append(m)
            client.send(message: m)
        }
        chatView.tableView.reloadData()
        chatView.tableView.scrollToRow(at: IndexPath(row: chatViewModel.messages.count - 1, section: 0), at: .bottom, animated: true)
        messageBar.messageTextField.field.text = ""
        messageBar.messageTextField.selectedPhoto = nil
        
    }
}

extension ChatViewController: ChatClientDelegate {
    func received(message: Message) {
        message.didUserSend = false
        chatViewModel.messages.append(message)
        chatView.tableView.reloadData()
        chatView.tableView.scrollToRow(at: IndexPath(row: chatViewModel.messages.count - 1, section: 0), at: .bottom, animated: true)
    }
}
