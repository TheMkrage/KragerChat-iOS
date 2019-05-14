//
//  ChatClient.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/13/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit
import Starscream

protocol ChatClientDelegate: class {
    func received(message: Message)
}

class ChatClient: NSObject {
    weak var delegate: ChatClientDelegate?
    
    var webSocket: WebSocket
    override init() {
        webSocket = WebSocket(url: URL(string: "ws://localhost:8000/ws")!)
        super.init()
        webSocket.delegate = self
        webSocket.connect()
    }
    
    deinit {
        webSocket.disconnect(forceTimeout: 0)
        webSocket.delegate = nil
    }

}

extension ChatClient: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print(text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print(data)
    }
}
