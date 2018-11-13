//
//  RedditSubredditDownloadService.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 11/12/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation

class RedditSubredditDownloadService {
    
    var redditModel = MetaRedditModel()
    
    var subreddits = [Subreddit]()
    
    func downloadListOfSubreddits(completion: @escaping () -> (Void)) {
        let urlString = "https://www.reddit.com/reddits.json"
        guard let url = URL(string: urlString) else { return }
        
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
                let subredditData = try JSONDecoder().decode(SubredditDataWrapper.self, from: data)
                self.subreddits = [Subreddit]()
                
                for p in subredditData.data.subreddits {
                    self.subreddits.append(p.data)
                }
                
                completion()
                
            } catch let jsonError {
                print("Error serializing JSON from remote server \(jsonError)")
            }
            
        }.resume()
    }
    
}
