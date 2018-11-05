//
//  ViewController.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 9/24/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import UIKit

class RisingStoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    
    let redditPostFetcher = RedditPostDownloadService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redditPostFetcher.downloadPosts {
            self.redditPostFetcher.sortPosts()
            
            DispatchQueue.main.async {
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditPostFetcher.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .white
        
        cell.title.text = redditPostFetcher.posts[indexPath.row].title
        cell.upvotes.text = " \(redditPostFetcher.posts[indexPath.row].upvotes) Upvotes"
        cell.comments.text = " \(redditPostFetcher.posts[indexPath.row].commentCount) Comments"
        
        cell.title.textColor = .black
        
        cell.redditPost = self.redditPostFetcher.posts[indexPath.row]
        return cell
    }


}
