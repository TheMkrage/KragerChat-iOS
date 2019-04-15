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
    
    lazy var chatView: ChatView = {
        chatViewModel.messages.append(Message(message: "Hey there!", didUserSend: true))
        chatViewModel.messages.append(Message(message: "This is Krager Chat!", didUserSend: false, sender: "Krager"))
        chatViewModel.messages.append(Message(message: "OMG! This app is so cool and way better than Ishaan Chat, Why? Because Ishaan chat doesnt and will never exist", didUserSend: true))
        let c = ChatView(viewModel: chatViewModel)
        return c
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(named: "bg")
        view.addSubview(chatView)
        
        setupConstraints()
        view.layoutIfNeeded()
    }
    
    private func setupConstraints() {
        chatView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        chatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        chatView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        chatView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
