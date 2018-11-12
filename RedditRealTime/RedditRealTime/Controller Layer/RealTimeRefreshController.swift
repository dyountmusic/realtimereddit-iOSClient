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
        
        if realTimeEnabled { return }
        
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
                self?.realTimeEnabled = true
                viewController.updateUI()
            }
            
        } else {
            // Fallback on earlier versions
            timerDispatchSourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            timerDispatchSourceTimer?.scheduleRepeating(deadline: .now(), interval: .seconds(60))
            timerDispatchSourceTimer?.setEventHandler{
                viewController.updateUI()
            }
            timerDispatchSourceTimer?.resume()
        }
        realTimeEnabled = true
    }
    
    func stopTimer() {
        
        realTimeEnabled = false
        
        timer?.invalidate()
        timerDispatchSourceTimer?.cancel()
    }
    
    
    
}
