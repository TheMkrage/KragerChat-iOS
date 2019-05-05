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
        "\"I'm Krager\"\n - Matthew Krager",
        "\"Hoch or Pitzer?\"\n - Matthew Krager",
        "\"WTF are you doing!?\"\n - Matthew Krager",
        "\"What's for dinner?\"\n - Matthew Krager",
        "\"This burger is delicious\"\n - Matthew Krager",
        "\"Swift is a great language\"\n - Matthew Krager",
        "\"You know what I don't understand\"\n - Matthew Krager",
    ]
}

protocol QuoteKeyboardDelegate: class {
    func selected(quote: String)
}

class QuoteKeyboard: Keyboard {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
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

extension QuoteKeyboard: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let quote = Quotes.all[indexPath.row]
        let width = UIScreen.main.bounds.width * 0.4
        
        let textView = QuoteTextView()
        textView.text = quote
        let textSize = textView.sizeThatFits(CGSize(width: width - (QuoteCell.padding * 2.0), height: CGFloat.greatestFiniteMagnitude))
        return CGSize(width: width, height: textSize.height + (QuoteCell.padding * 2.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Quotes.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let quote = Quotes.all[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quote", for: indexPath) as? QuoteCell else {
            return UICollectionViewCell()
        }
        cell.quoteTextView.text = quote
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quote = Quotes.all[indexPath.row]
        delegate?.selected(quote: quote)
    }
}
