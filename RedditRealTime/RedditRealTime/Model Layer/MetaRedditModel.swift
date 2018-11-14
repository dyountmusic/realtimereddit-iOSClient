//
//  MetaRedditModel.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 11/12/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation

class MetaRedditModel {
    
    public var subredditName: String {
        get { return UserDefaults.standard.string(forKey: "SubredditName")?.capitalized ?? "Politics" }
        set {
            UserDefaults.standard.set(newValue, forKey: "SubredditName")
            redditURL = "https://www.reddit.com/r/\(newValue)/rising.json?sort=new&raw_json=1"
        }
    }
    
    public var redditURL: String {
        get { return UserDefaults.standard.string(forKey: "RedditURL") ?? "https://www.reddit.com/r/politics/rising.json?sort=new&raw_json=1" }
        set { UserDefaults.standard.set(newValue, forKey: "RedditURL") }
    }
    
    func resetRedditURL() {
        redditURL = "https://www.reddit.com/r/politics/rising.json?sort=new&raw_json=1"
        subredditName = "Politics"
    }
    
}
