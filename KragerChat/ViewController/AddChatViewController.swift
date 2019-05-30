//
//  AddChatViewController.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/19/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

enum AddChatType {
    case new, code
    
    static let all = [AddChatType.new, AddChatType.code]
    
    var title: String {
        get {
            switch self {
            case .new:
                return "New Chat"
            case .code:
                return "Add Chat by Code"
            }
        }
    }
}

class AddChatViewController: UIViewController {
    
    lazy var ChatTypeSegmentedControl: UISegmentedControl = {
        let s = UISegmentedControl(items: AddChatType.all.map({ $0.title }))
        s.translatesAutoresizingMaskIntoConstraints = false
        s.selectedSegmentIndex = 0
        s.addTarget(self, action: #selector(changedChatType(_:)), for: .valueChanged)
        return s
    }()
    
    var textField: KragerTextField = {
        let k = KragerTextField()
        return k
    }()
    
    lazy var createButton: KragerButton = {
        let b = KragerButton()
        b.setTitle("Create", for: .normal)
        b.addTarget(self, action: #selector(create), for: .touchUpInside)
        return b
    }()
    
    var chatType: AddChatType = .new
    
    var threadStore: ThreadStore
    
    init(threadStore: ThreadStore) {
        self.threadStore = threadStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.placeholder = "Name the New Chat!"
        title = "Add Chat"
        
        view.backgroundColor = UIColor.init(named: "bg")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        
        view.addSubview(ChatTypeSegmentedControl)
        view.addSubview(textField)
        view.addSubview(createButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        ChatTypeSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25.0).isActive = true
        ChatTypeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        textField.topAnchor.constraint(equalTo: ChatTypeSegmentedControl.bottomAnchor, constant: 35.0).isActive = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.60).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        createButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20.0).isActive = true
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
    }
    
    @objc func changedChatType(_ sender: UISegmentedControl) {
        let type = AddChatType.all[sender.selectedSegmentIndex]
        textField.text = ""
        chatType = type
        switch chatType {
        case .new:
            textField.placeholder = "Name the New Chat!"
        case .code:
            textField.placeholder = "Enter the Chat's Code!"
        }
    }
    
    @objc func create() {
        switch chatType {
        case .new:
            threadStore.create(name: textField.text ?? "") { (id) in
                self.dismiss(animated: true, completion: nil)
            }
        case .code:
            guard let code = Int(textField.text ?? "") else {
                return 
            }
            threadStore.join(id: code)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}
