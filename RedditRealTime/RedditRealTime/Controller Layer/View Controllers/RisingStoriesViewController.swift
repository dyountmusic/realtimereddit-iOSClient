//
//  ViewController.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 9/24/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import UIKit
import SafariServices

class RisingStoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerPreviewingDelegate {
    
    @IBOutlet weak var realTimeIcon: UIBarButtonItem!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var realTimeBarButton: UIBarButtonItem!
    @IBOutlet weak var subredditBarButton: UIBarButtonItem!
    
    let redditPostFetcher = RedditPostDownloadService()
    let realTimeController = RealTimeRefreshController()
    private let refreshControl = UIRefreshControl()
    
    //MARK: UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFirstTimeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpTimer()
        self.title = redditPostFetcher.redditModel.subredditName
        updateUI()
    }
    
    //MARK: Set Up Functions
    
    private func setUpFirstTimeUI() {
        // Register for 3D touch Peak and Pop
        if (traitCollection.forceTouchCapability == .available) {
            registerForPreviewing(with: self, sourceView: view)
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpTableView()
        setUpRefreshControl()
        updateUI()
    }
    
    private func setUpTimer() {
        realTimeController.startTimer(viewController: self)
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
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
    
    // Called when Refresh Control Detects a "Pull-to-Refresh" gesture
    
    @objc private func refreshPosts(_ sender: Any) {
        updateUI()
    }
    
    // MARK: UI Methods
    
    /// Use this method generally to call for new posts, upvotes, comments and other data
    /// And to handle the timer logic for real time refresh
    func updateUI() {
        print("Refreshing posts...")
        redditPostFetcher.downloadPosts {
            self.redditPostFetcher.sortPosts()
            DispatchQueue.main.async {
                self.refreshControl.beginRefreshing()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                
                if self.redditPostFetcher.redditModel.subredditName != self.title {
                    self.title = self.redditPostFetcher.redditModel.subredditName
                }
                
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
        
        switch redditPostFetcher.posts[indexPath.row].upvotes {
        case 50...99:
            cell.upvotes.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case 100...249:
            cell.upvotes.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case 250...499:
            cell.upvotes.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case 500...999:
            cell.upvotes.backgroundColor = #colorLiteral(red: 1, green: 0.3648655713, blue: 0, alpha: 1)
        case 1000...:
            cell.upvotes.backgroundColor = #colorLiteral(red: 0.9689580798, green: 0, blue: 0, alpha: 1)
        default:
            cell.upvotes.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        
        cell.redditPost = self.redditPostFetcher.posts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = redditPostFetcher.posts[indexPath.row].url
        
        let config = SFSafariViewController.Configuration.init()
        config.entersReaderIfAvailable = true
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    // MARK: Peak and Pop Functions
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        guard let cell = tableView.cellForRow(at: indexPath) else { return nil }
        let urlString = redditPostFetcher.posts[indexPath.row].url
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let config = SFSafariViewController.Configuration.init()
        config.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: config)
        vc.preferredContentSize = CGSize(width: 0.0, height: 600)
        previewingContext.sourceRect = cell.frame
        return vc
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true)
    }
    
    @IBAction func unwindToRisingStories(segue: UIStoryboardSegue) {
        
    }


}
