//
//  Post.swift
//  Post
//
//  Created by Eva Marie Bresciano on 6/1/16.
//  Copyright © 2016 Eva Bresciano. All rights reserved.
//

import Foundation

class Post {
    
    private let kUsername = "username"
    private let kText = "text"
    private let kTimeStamp = "time"
    private let kIdentifier = "identifier"
    
    let userName: String
    let text: String
    let timeStamp: NSTimeInterval
    let indentifier: NSUUID
    
    init(userName: String, text: String, identifier: NSUUID = NSUUID()) {
        self.userName = userName
        self.text = text
        self.timeStamp = NSDate().timeIntervalSince1970
        self.indentifier = identifier
        
    }
    
    init?(JSONDictionary: [String:AnyObject]) {
        guard let userName = JSONDictionary[kUsername] as? String,
        let text = JSONDictionary[kText] as? String,
        let timeStamp = JSONDictionary[kTimeStamp] as? NSTimeInterval,
            let identifier = JSONDictionary[kIdentifier] as? NSUUID else {
                return nil }
        self.userName = userName
        self.text = text
        self.timeStamp = NSDate().timeIntervalSince1970
        self.indentifier = identifier

    }
}