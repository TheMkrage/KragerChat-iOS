//
//  ThreadStore.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/17/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class ThreadStore: NSObject {
    
    func getAll() -> [Thread] {
        let userDefaults = UserDefaults.standard
        guard let threadsData = userDefaults.array(forKey: "threads") as? [Data] else {
            return []
        }
        let threads = threadsData.map { (data) -> Thread? in
            guard let thread = try? PropertyListDecoder().decode(Thread.self, from: data) else {
                return nil
            }
            return thread
        }
        guard let toReturn = threads.filter({ (thread) -> Bool in
            return thread != nil
        }) as? [Thread] else {
            return [Thread]()
        }
        return toReturn
    }
    
    private func getData(thread: Thread) -> Data? {
        let data = try? PropertyListEncoder().encode(thread)
        return data
    }
    
    private func save(thread: Thread) {
        let userDefaults = UserDefaults.standard
        guard let threadsData = userDefaults.array(forKey: "threads") as? [Data] else {
            // add array
            userDefaults.set([getData(thread: thread)], forKey: "threads")
            userDefaults.synchronize()
            return
        }
        
        var newThreads = threadsData
        guard let data = getData(thread: thread) else {
            return
        }
        newThreads.append(data)
        userDefaults.set(newThreads, forKey: "threads")
        userDefaults.synchronize()
    }
    
    func create(name: String, callback: ((Int) -> Void)?) {
        let url = URL(string: "https://\(Backend.url)/threads")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let postData = NSMutableData(data: "name=\(name)".data(using: String.Encoding.utf8)!)
        request.httpBody = postData as Data
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let _ = response as? HTTPURLResponse, error == nil else {
                    print("error", error ?? "Unknown error")
                    return
            }
            do {
                let decoder = JSONDecoder()
                let thread = try decoder.decode(Thread.self, from: data)
                self.save(thread: thread)
                callback?(thread.id)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func join(id: Int) {
        let url = URL(string: "https://\(Backend.url)/threads/\(id)/join")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "apn_token": "Test Thred"
        ]
        guard let body = (try? JSONSerialization.data(withJSONObject: parameters, options: [])) else {
            return
        }
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse, error == nil else {
                    print("error", error ?? "Unknown error")
                    return
            }
            do {
                let decoder = JSONDecoder()
                let thread = try decoder.decode(Thread.self, from: data)
                self.save(thread: thread)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func getMessages(id: Int, page: Int = 0, callback: (([Message]) -> Void)?) {
        let url = URL(string: "https://\(Backend.url)/threads/\(id)/messages?page=\(page)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let _ = response as? HTTPURLResponse, error == nil else {
                    print("error", error ?? "Unknown error")
                    return
            }
            do {
                let decoder = JSONDecoder()
                let messages = try decoder.decode([Message].self, from: data)
                // Filter out the invalid photo objects received from the backend
                let filteredMessages = messages.map({ (message) -> Message in
                    if message.photo == nil || message.photo?.id == 0 {
                        message.photo = nil
                    }
                    return message
                })
                callback?(filteredMessages)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
}
