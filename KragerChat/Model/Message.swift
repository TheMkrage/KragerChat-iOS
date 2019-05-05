//
//  Message.swift
//  KragerChat
//
//  Created by Matthew Krager on 4/13/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class Message: NSObject {
    var contents: String
    var photo: Photo?
    var didUserSend: Bool
    var sender: String
    
    init(message: String = "", photo: Photo? = nil, didUserSend: Bool, sender: String = "") {
        self.contents = message
        self.photo = photo
        self.didUserSend = didUserSend
        self.sender = sender
    }
}
