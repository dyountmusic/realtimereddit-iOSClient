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
    @IBOutlet weak var subredditTextField: UITextField!
    @IBOutlet weak var loginButton: ActionButton!
    
    override func viewDidLoad() {
        loginButton.isHidden = true
    }
    
}
