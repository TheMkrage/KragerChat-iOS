//
//  ThreadStore.swift
//  KragerChat
//
//  Created by Matthew Krager on 5/17/19.
//  Copyright © 2019 Matthew Krager. All rights reserved.
//

import UIKit

class ThreadStore: NSObject {
    func join(id: Int) {
        // join Thread
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
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        
        task.resume()
        
        var userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: teams)
        userDefaults.set(encodedData, forKey: "teams")
        userDefaults.synchronize()
    }
}
