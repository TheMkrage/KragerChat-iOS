//
//  Message.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/13/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class Message: NSObject, Codable {
    var contents: String
    var senderID: Int
    var photo: Photo?
    var sender: String
    
    private func getID() -> Int {
        let userDefaults = UserDefaults.standard
        guard let id = userDefaults.object(forKey: "id") as? Int else {
            let newId = Int.random(in: 0 ..< 100000000)
            userDefaults.set(newId, forKey: "id")
            userDefaults.synchronize()
            return newId
        }
        return id
    }
    
    var didUserSend: Bool {
        get {
            return senderID == getID()
        }
    }
    
    init(message: String = "", photo: Photo? = nil, sender: String = "", senderID: Int) {
        self.contents = message
        self.photo = photo
        self.sender = sender
        self.senderID = senderID
    }
}
