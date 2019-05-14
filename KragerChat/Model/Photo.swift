//
//  Photo.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/4/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class Photos: NSObject {
    static let all = [
        Photo(name: "krager-smiling", id: 0),
        Photo(name: "krager-coffee", id: 1)
    ]
    
    static func get(id: Int) -> Photo {
        return all[id]
    }
}

class Photo: NSObject, Codable {
    var name: String
    var id: Int
    var image: UIImage {
        get {
            return UIImage(named: name)!
        }
    }
    
    fileprivate init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}
