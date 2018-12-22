//
//  RealTimeSettingsTableViewController.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 11/15/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import UIKit

class RealTimeSettingsTableViewController: UITableViewController {

    @IBOutlet weak var realTimeRefreshSwitch: UISwitch!
    @IBOutlet weak var willDeviceSleepSwitch: UISwitch!
    
    var redditModel = MetaRedditModel()
    
    var realTimeEnabled: Bool {
        get { return UserDefaults.standard.bool(forKey: "RealTimeEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "RealTimeEnabled") }
    }
    
    var willDeviceSleep: Bool {
        get { return UserDefaults.standard.bool(forKey: "DeviceSleepEnabled") }
        set {
            UserDefaults.standard.set(newValue, forKey: "DeviceSleepEnabled")
            UIApplication.shared.isIdleTimerDisabled = newValue
        }
    }
    
    fileprivate func checkForRealTime() {
        if realTimeEnabled {
            realTimeRefreshSwitch.isOn = true
        } else {
            realTimeRefreshSwitch.isOn = false
        }
    }
    
    fileprivate func checkForDeviceSleep() {
        if willDeviceSleep {
            willDeviceSleepSwitch.isOn = true
        } else {
            willDeviceSleepSwitch.isOn = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForRealTime()
        checkForDeviceSleep()
    }
    
    @IBAction func realTimeRefreshSwitchTapped(_ sender: Any) {
        if realTimeRefreshSwitch.isOn {
            realTimeEnabled = true
        } else {
            realTimeEnabled = false
        }
    }
    
    @IBAction func willDeviceSleepSwitchTapped(_ sender: Any) {
        if willDeviceSleepSwitch.isOn {
            presentKeepDisplayOnAlert()
            willDeviceSleep = true
        } else {
            willDeviceSleep = false
        }
    }
    
    func presentKeepDisplayOnAlert() {
        let alert = UIAlertController(title: "Warning", message: "Leaving this option enabled for long periods of time can have an adverse effect on battery life and in rare cases cause display retention. Use at your own risk.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }

}
