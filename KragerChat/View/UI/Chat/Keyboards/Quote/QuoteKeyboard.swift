//
//  QuoteKeyboard.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/21/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class Quotes {
    static let all = [
        "I'm Krager",
        "Hoch or Pitzer?",
        "WTF are you doing!?",
        "Whats for dinner?",
    ]
}

protocol QuoteKeyboardDelegate: class {
    func selected(quote: String)
}

class QuoteKeyboard: Keyboard {

    var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    weak var delegate: QuoteKeyboardDelegate?
    
    var didSetConstraints = false
    
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
        backgroundColor = .red
        
        addSubview(collectionView)
    }
    
    override func updateConstraints() {
        defer {
            super.updateConstraints()
        }
        guard !didSetConstraints else {
            return
        }
        didSetConstraints = true
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension QuoteKeyboard: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Quotes.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let quote = Quotes.all[indexPath.row]
        let cell = QuoteCell()
        
        return cell
    }
    
    
}
