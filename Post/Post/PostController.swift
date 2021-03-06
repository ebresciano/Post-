//
//  PostController.swift
//  Post
//
//  Created by Eva Marie Bresciano on 6/1/16.
//  Copyright © 2016 Eva Bresciano. All rights reserved.
//

import Foundation

class PostController {
    
    weak var delegate: PostControllerDelegate?
    
    init () {
        fetchPosts()
    }
    
    var posts: [Post] = []
    
    static let baseURL = NSURL(string: "https://devmtn-post.firebaseio.com/posts/")
    
    static let endpoint = baseURL?.URLByAppendingPathExtension("/posts.json")
    
    
    func fetchPosts(reset reset: Bool = true, completion: ((posts: [Post]) -> Void)? = nil) {
        guard let url = PostController.endpoint else {fatalError("URL optional is nil")}
        

        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
    if let data = data,
    responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) {
    guard let responseDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String:AnyObject],
    postDictionaries = responseDictionary["posts"] as? [[String:AnyObject]] else {
    print("Unable to serialize JSON. \nResponse: \(responseDataString)")
    completion?(posts: [])
    return
   }
    let posts = postDictionaries.flatMap{Post(JSONDictionary:$0)}
            completion?(posts: posts)
            
            let sortedPosts = posts.sort({$0.0.timeStamp > $0.1.timeStamp})
            
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if reset {
                    self.posts = sortedPosts
                } else {
                    self.posts.appendContentsOf(sortedPosts)
                }
                if let completion = completion {
                    completion(posts: sortedPosts)
                }
                
                return
        })
     }
   }
}

}

protocol PostControllerDelegate: class {
    func postsUpdated(posts: [Post])

}
    
    
