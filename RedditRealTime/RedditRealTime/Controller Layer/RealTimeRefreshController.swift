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
    var timerDispatchSourceTimer : DispatchSourceTimer?
    
    func startTimer(viewController: RisingStoriesViewController) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            if !self.realTimeEnabled {
                self.stopTimer()
                return
            }
            viewController.updateUI()
        }
    }
    
    func stopTimer() {
        
        realTimeEnabled = false
        
        timer?.invalidate()
        timerDispatchSourceTimer?.cancel()
    }
}
