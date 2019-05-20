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
    
    var closeButton: UIButton = {
        let c = UIButton()
        return c
    }()
    
    var threadTypeSegmentedControl: UISegmentedControl = {
        let s = UISegmentedControl(items: AddChatType.all.map({ $0.title }))
        return s
    }()
    
    var textField: KragerTextField = {
        let k = KragerTextField()
        return k
    }()
    
    lazy var createButton: KragerButton = {
        let b = KragerButton()
        b.setTitle("Create", for: .normal)
        return b
    }()
    
    var completedMessageLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        
        view.addSubview(threadTypeSegmentedControl)
        view.addSubview(textField)
        view.addSubview(createButton)
        view.addSubview(completedMessageLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}
