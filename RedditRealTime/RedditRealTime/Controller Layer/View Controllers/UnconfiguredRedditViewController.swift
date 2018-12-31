//
//  UnconfiguredRedditViewController.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 12/21/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import UIKit

class UnconfiguredRedditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var subredditTableView: UITableView!
    
    var redditModel = MetaRedditModel()
    var subredditService = RedditSubredditDownloadService()
    
    override func viewDidLoad() {
        subredditTableView.dataSource = self
        subredditTableView.delegate = self
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    func updateUI() {
        subredditService.downloadListOfSubreddits {
            DispatchQueue.main.async {
                self.subredditTableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = subredditTableView.dequeueReusableCell(withIdentifier: "SubredditCell") as? SubredditTableViewCell else {
            return UITableViewCell()
        }
        cell.name.text = subredditService.subreddits[indexPath.row].displayName
        cell.backgroundColor = .white
        cell.name.textColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subredditService.subreddits.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        redditModel.subredditName = subredditService.subreddits[indexPath.row].displayName
        
        print("Selected \(redditModel.subredditName)")
        
        performSegue(withIdentifier: "segueToRisingStoriesView", sender: nil)
    }
    
    

}
