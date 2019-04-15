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
    var didUserSend: Bool
    var sender: String
    
    init(message: String, didUserSend: Bool, sender: String = "") {
        self.contents = message
        self.didUserSend = didUserSend
        self.sender = sender
    }
}
