//
//  PostDownloader.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 10/29/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation

class RedditPostDownloadService {
    
    // MARK: Properties
    
    // These properties are used to store the fetched data for reference
    var posts = [RedditPost]()
    
    //Stores the hash values of the previous state. Used for animating updates to post list
    var previousState = [Int]()
    
    // MARK: Functions
    
    func downloadPosts(completion: @escaping () -> (Void)) {
        
        //save the current state before it is overwritten
        previousState = computeState()
        
        let jsonURLString = "https://www.reddit.com/r/politics.json"
        guard let url = URL(string: jsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("A fatal error occured when retrieving data from the server with \(String(describing: error))")
                return
            }
            
            let status = (response as! HTTPURLResponse).statusCode
            
            if status != 200 {
                print("Status code looks a bit weird, check it out: \(status)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let redditData = try JSONDecoder().decode(RedditDataWrapper.self, from: data)
                self.posts = [RedditPost]()
                
                for p in redditData.data.posts {
                    self.posts.append(p.data)
                }
                
                self.sortPosts()
                
                self.removeDuplicates()
                
                completion()
                
            } catch let jsonError {
                print("Error serializing JSON from remote server \(jsonError)")
            }
            }.resume()
    }
    
    func sortPosts() {
        
        let sortedPosts = posts.sorted(by: { $0.upvotes > $1.upvotes })
        posts = sortedPosts
        
    }
    
    func removeDuplicates() {
        var uniquePosts = [RedditPost]()
        for post in posts {
            if !uniquePosts.contains(post) {
                uniquePosts.append(post)
            }
        }
        posts = uniquePosts
    }
    
    func computeState() -> [Int] {
        var state = [Int]()
        for post in posts {
            state.append(post.hashValue)
        }
        return state
    }
    
}
