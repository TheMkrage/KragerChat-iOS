//
//  Thread.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/17/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class Thread: Codable {
    var name: String
    var id: Int
    var lastMessage: Message?
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}
