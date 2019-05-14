//
//  ChatClient.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/13/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

protocol ChatClientDelegate: class {
    func received(message: Message)
}

class ChatClient: NSObject {
    weak var delegate: ChatClientDelegate?
    
    // Stream
    var inputStream: InputStream
    var outputStream: OutputStream
    
    override init() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        // create the streams at their respective addresses
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "localhost" as CFString, 8000, &readStream, &writeStream)
        // releases data at read and write
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        super.init()
        
        inputStream.delegate = self
        
        inputStream.schedule(in: .current, forMode: RunLoop.Mode.common)
        outputStream.schedule(in: .current, forMode: RunLoop.Mode.common)
        inputStream.open()
        outputStream.open()
    }
}

extension ChatClient: StreamDelegate {
    
    private func readAvailableBytes(stream: InputStream) {
        let maxReadLength = 4096
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        while stream.hasBytesAvailable {
            let numberOfBytesRead = inputStream.read(buffer, maxLength: maxReadLength)
            if numberOfBytesRead < 0 {
                if let _ = stream.streamError {
                    break
                }
            }
            
            //Construct the Message object from buffer
            processedMessageString(buffer: buffer, length: numberOfBytesRead)
        }
    }
    
    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>, length: Int) -> Message? {
        guard let stringArray = String(bytesNoCopy: buffer, length: length, encoding: .ascii, freeWhenDone: true)?.components(separatedBy: ":"),
            let name = stringArray.first,
            let message = stringArray.last else {
                return nil
        }
        print(stringArray)
        print(String(bytesNoCopy: buffer, length: length, encoding: .ascii, freeWhenDone: true))
        return Message(message: message, photo: nil, didUserSend: false, sender: "")
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        if eventCode == .hasBytesAvailable {
            readAvailableBytes(stream: aStream as! InputStream)
        }
    }
}
