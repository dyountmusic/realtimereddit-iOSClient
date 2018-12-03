//
//  PostTableViewCell.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 10/29/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var upvotes: PillUILabel!
    @IBOutlet weak var comments: UILabel!
    
    //var redditAPIService: RedditAPIService?
    var redditPost: RedditPost?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
