//
//  RealTimeRefreshController.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 11/12/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation

class RealTimeRefreshController {
    
    var isRealTime = false
    weak var timer: Timer?
    var timerDispatchSourceTimer : DispatchSourceTimer?
    
    func startTimer(viewController: RisingStoriesViewController) {
        
        if isRealTime { return }
        
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
                self?.isRealTime = true
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
        isRealTime = true
    }
    
    func stopTimer() {
        
        isRealTime = false
        
        timer?.invalidate()
        timerDispatchSourceTimer?.cancel()
    }
    
    
    
}
