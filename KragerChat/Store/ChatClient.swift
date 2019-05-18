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
        webSocket = WebSocket(url: URL(string: "ws://\(Backend.url)/ws")!)
        super.init()
        webSocket.delegate = self
        webSocket.connect()
    }
    
    deinit {
        webSocket.disconnect(forceTimeout: 0)
        webSocket.delegate = nil
    }
    
    func send(message: Message) {
        do {
            let jsonData = try JSONEncoder().encode(message)
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                return
            }
            print(jsonString)
            webSocket.write(string: jsonString)
        } catch {
            print("error encoding")
        }
    }
}

extension ChatClient: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("connect")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("disconnect")
        print(error)
        webSocket.connect()
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print(text)
        guard let jsonData = text.data(using: .utf8) else {
            return
        }
        do {
            let message = try JSONDecoder().decode(Message.self, from: jsonData)
            if message.photo?.id == 0 {
                message.photo = nil
            }
            delegate?.received(message: message)
        } catch let jsonError {
            print(jsonError)
            print("could not receive message")
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
}
