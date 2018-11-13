//
//  SubredditModel.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 11/12/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation

struct SubredditDataWrapper: Codable {
    let kind: String
    let data: SubredditData
}

struct SubredditData: Codable {
    let subreddits: [Subreddits]
    
    enum CodingKeys: String, CodingKey {
        case subreddits = "children"
    }
}

struct Subreddits: Codable {
    let data: Subreddit
}

struct Subreddit: Codable {
    let displayName: String
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
    }
}
