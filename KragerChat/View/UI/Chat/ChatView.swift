//
//  ChatView.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/12/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class ChatView: UIView {
    
    var viewModel: ChatViewModel
    var didSetConstraints = false
    
    var tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = 100
        t.separatorStyle = .none
        t.backgroundColor = .clear
        return t
    }()
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        viewModel = ChatViewModel()
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(tableView)
    }
    
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        didSetConstraints = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension ChatView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.messages[indexPath.row]
        if message.didUserSend ?? false {
            let cell = MessageSentCell(style: .default, reuseIdentifier: "sent")
            cell.messageLabel.text = message.contents
            cell.photoView.image = message.photo?.image
            return cell
        } else {
            let cell = MessageReceivedCell(style: .default, reuseIdentifier: "received")
            cell.messageLabel.text = message.contents
            cell.photoView.image = message.photo?.image
            cell.nameLabel.text = message.sender
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
