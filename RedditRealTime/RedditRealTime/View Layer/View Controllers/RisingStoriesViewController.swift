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
    @IBOutlet weak var realTimeBarButton: UIBarButtonItem!
    @IBOutlet weak var subredditBarButton: UIBarButtonItem!
    
    let redditPostFetcher = RedditPostDownloadService()
    let realTimeController = RealTimeRefreshController()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setUpRefreshControl()
        setUpTimer()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        setUpTimer()
        self.title = redditPostFetcher.redditModel.subredditName
    }
    
    private func setUpTimer() {
        realTimeController.startTimer(viewController: self)
    }
    
    private func setUpRefreshControl() {
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(refreshPosts(_:)), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 1, green: 0.2888048291, blue: 0.1251261532, alpha: 1)
        
        let attributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.2888048291, blue: 0.1251261532, alpha: 1)]
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Reddit Posts...", attributes: attributes)
    }
    
    @objc private func refreshPosts(_ sender: Any) {
        updateUI()
    }
    
    func updateUI() {
        
        if realTimeController.realTimeEnabled {
            realTimeBarButton.tintColor = .blue
        }
        
        print("Refreshing posts...")
        redditPostFetcher.downloadPosts {
            
            self.redditPostFetcher.sortPosts()
            
            DispatchQueue.main.async {
                self.refreshControl.beginRefreshing()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditPostFetcher.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell else { return UITableViewCell() }
        
        cell.title.text = redditPostFetcher.posts[indexPath.row].title
        cell.upvotes.text = " \(redditPostFetcher.posts[indexPath.row].upvotes)"
        cell.comments.text = " \(redditPostFetcher.posts[indexPath.row].commentCount) Comments"
        
        cell.redditPost = self.redditPostFetcher.posts[indexPath.row]
        return cell
    }
    
    @IBAction func unwindToRisingStories(segue: UIStoryboardSegue) {
        
    }


}
