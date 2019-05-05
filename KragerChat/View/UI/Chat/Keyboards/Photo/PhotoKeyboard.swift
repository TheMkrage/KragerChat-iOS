//
//  PhotoKeyboard.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/21/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

protocol PhotoKeyboardDelegate: class {
    func selected(photo: Photo)
}

class PhotoKeyboard: Keyboard {

    var didSetConstraints = false
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .clear
        c.dataSource = self
        c.delegate = self
        c.translatesAutoresizingMaskIntoConstraints = false
        c.register(PhotoCell.self, forCellWithReuseIdentifier: "photo")
        return c
    }()
    
    weak var delegate: PhotoKeyboardDelegate?
    
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
        collectionView.reloadData()
        backgroundColor = UIColor.init(named: "bg")
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

extension PhotoKeyboard: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Photos.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photo = Photos.all[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.imageView.image = photo.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = Photos.all[indexPath.row]
        let image = photo.image
        let padding = (PhotoCell.padding * 2.0)
        let imageWidth = UIScreen.main.bounds.width * 0.4 - padding
        
        let aspectRatio = image.size.height / image.size.width
        let imageHeight = aspectRatio * imageWidth
        
        return CGSize(width: imageWidth + padding, height: imageHeight + padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = Photos.all[indexPath.row]
        delegate?.selected(photo: photo)
    }
}
