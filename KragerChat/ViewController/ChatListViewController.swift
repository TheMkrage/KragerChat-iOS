//
//  ChatListViewController.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/19/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.separatorColor = .white
        t.delegate = self
        t.dataSource = self
        t.rowHeight = UITableView.automaticDimension
        return t
    }()
    
    var globalChatButton: KragerButton = {
        let b = KragerButton()
        b.setTitle("🌎 Global Chat 🌎", for: .normal)
        b.addTarget(self, action: #selector(globalChat(_:)), for: .touchUpInside)
        return b
    }()
    
    var addChatButton: KragerButton = {
        let b = KragerButton()
        b.setTitle("+", for: .normal)
        b.addTarget(self, action: #selector(addChat(_:)), for: .touchUpInside)
        return b
    }()
    
    var threadStore = ThreadStore()
    
    lazy var viewModel: ChatListViewModel = {
        let vm = ChatListViewModel()
        return vm
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        // Add newThreads to the viewModel without clearing old ones
        let newThreads = threadStore.getAll().filter { (thread) -> Bool in
            return !viewModel.threads.contains(where: { (_thread) -> Bool in
                return _thread.id == thread.id
            })
        }
        viewModel.threads.append(contentsOf: newThreads)
        for thread in viewModel.threads {
            threadStore.getMessages(id: thread.id) { (messages) in
                thread.messages = messages
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chats"
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = item
        
        view.backgroundColor = UIColor.init(named: "bg")
        view.addSubview(addChatButton)
        view.addSubview(globalChatButton)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        globalChatButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15.0).isActive = true
        globalChatButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        globalChatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        globalChatButton.trailingAnchor.constraint(equalTo: addChatButton.leadingAnchor, constant: -50).isActive = true
        
        addChatButton.heightAnchor.constraint(equalTo: addChatButton.widthAnchor).isActive = true
        addChatButton.heightAnchor.constraint(equalTo: globalChatButton.heightAnchor, multiplier: 0.75).isActive = true
        addChatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addChatButton.centerYAnchor.constraint(equalTo: globalChatButton.centerYAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: globalChatButton.bottomAnchor, constant: 15.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func globalChat(_ sender: UIButton) {
        let vc = ChatViewController(threadID: 0)
        show(vc, sender: self)
    }
    
    @objc func addChat(_ sender: UIButton) {
        let vc = AddChatViewController(threadStore: threadStore)
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.barTintColor = UIColor.init(named: "bg")
        nav.navigationBar.tintColor = .white
        nav.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        nav.navigationBar.isTranslucent = false
        present(nav, animated: true, completion: nil)
    }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.threads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thread = viewModel.threads[indexPath.row]
        let cell = ChatListTableViewCell(style: .default, reuseIdentifier: "chatList")
        cell.nameLabel.text = thread.name
        cell.lastMessageLabel.text = thread.messages?.last?.contents
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thread = viewModel.threads[indexPath.row]
        let vc = ChatViewController(threadID: thread.id)
        vc.chatViewModel.messages = thread.messages ?? []
        show(vc, sender: self)
    }
}
