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
        guard let threads = userDefaults.array(forKey: "threads") as? [Thread] else {
            return []
        }
        return threads
    }
    
    private func save(thread: Thread) {
        let userDefaults = UserDefaults.standard
        guard let threads = userDefaults.array(forKey: "threads") as? [Thread] else {
            // add array
            userDefaults.set([thread], forKey: "threads")
            userDefaults.synchronize()
            return
        }
        
        var newThreads = threads
        newThreads.append(thread)
        userDefaults.set(newThreads, forKey: "threads")
        userDefaults.synchronize()
    }
    
    func join(id: Int) {
        let url = URL(string: "http://\(Backend.url)/threads/\(id)/join")!
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
}
