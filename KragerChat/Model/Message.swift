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
    
    init(message: String, didUserSend: Bool) {
        self.contents = message
        self.didUserSend = didUserSend
    }
}
