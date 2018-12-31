//
//  ChangeSubredditView.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 11/12/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation
import UIKit

class ChangeSubredditView: UITableViewController {
    
    @IBOutlet var subredditTable: UITableView!
    
    var subredditDownloadService = RedditSubredditDownloadService()
    var redditModel = MetaRedditModel()
    
    override func viewDidLoad() {
        subredditTable.tableFooterView = UIView()
        subredditTable.dataSource = self
        updateUI()
    }
    
    func updateUI() {
        subredditDownloadService.downloadListOfSubreddits {
            DispatchQueue.main.async {
                self.subredditTable.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = subredditTable.dequeueReusableCell(withIdentifier: "SubredditCell") as? SubredditTableViewCell else {
                return UITableViewCell()
            }
        
        cell.name.text = subredditDownloadService.subreddits[indexPath.row].displayName
        cell.backgroundColor = .white
        cell.name.textColor = .black
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if redditModel.subredditName == subredditDownloadService.subreddits[indexPath.row].displayName.capitalized {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subredditDownloadService.subreddits.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        redditModel.subredditName = subredditDownloadService.subreddits[indexPath.row].displayName
        performSegue(withIdentifier: "unwindToRisingStoriesWithSegue", sender: self)
    }
    
    @IBAction func unwindToRisingStoriesWithSegue(segue: UIStoryboardSegue) {
        
    }
    
}
