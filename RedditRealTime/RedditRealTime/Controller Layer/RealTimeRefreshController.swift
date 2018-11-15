//
//  RealTimeRefreshController.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 11/12/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation

class RealTimeRefreshController {
    
    var realTimeEnabled: Bool {
        get { return UserDefaults.standard.bool(forKey: "RealTimeEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "RealTimeEnabled") }
    }
    
    weak var timer: Timer?
    
    func startTimer(viewController: RisingStoriesViewController) {
        
        if !realTimeEnabled {
            stopTimer()
            return
        }
        
        // Prevents duplicate timers
        stopTimer()
        
        print("Starting timer.")
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            viewController.updateUI()
        }
    }
    
    func stopTimer() {
        print("Stopping timer.")
        
        timer?.invalidate()
    }
}
