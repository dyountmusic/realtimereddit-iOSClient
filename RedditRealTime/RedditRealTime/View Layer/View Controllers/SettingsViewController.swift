//
//  SettingsViewController.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 11/12/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var realTimeRefreshSwitch: UISwitch!
    @IBOutlet weak var loginButton: ActionButton!
    @IBOutlet weak var subredditName: UIButton!
    
    var redditModel = MetaRedditModel()
    
    var realTimeEnabled: Bool {
        get { return UserDefaults.standard.bool(forKey: "RealTimeEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "RealTimeEnabled") }
    }
    
    fileprivate func checkForRealTime() {
        if realTimeEnabled {
            realTimeRefreshSwitch.isOn = true
        } else {
            realTimeRefreshSwitch.isOn = false
        }
    }
    
    override func viewDidLoad() {
        loginButton.isHidden = true
        subredditName.setTitle(redditModel.subredditName, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkForRealTime()
    }
    
    @IBAction func refreshSwitchTapped(_ sender: Any) {
        if realTimeRefreshSwitch.isOn {
            realTimeEnabled = true
        } else {
            realTimeEnabled = false
        }
    }
    
}
