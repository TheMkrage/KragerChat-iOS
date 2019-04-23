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

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .clear
        c.dataSource = self
        c.delegate = self
        c.translatesAutoresizingMaskIntoConstraints = false
        c.register(QuoteCell.self, forCellWithReuseIdentifier: "quote")
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
        backgroundColor = UIColor.init(named: "bg")
        collectionView.reloadData()
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
        print(Quotes.all.count)
        return Quotes.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let quote = Quotes.all[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quote", for: indexPath) as? QuoteCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}
