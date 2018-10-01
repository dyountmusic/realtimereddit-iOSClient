//
//  ActionButton.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 10/1/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ActionButton: UIButton {
    
    // MARK: IBInspectable Variables
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    
    // MARK: Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        // Common logic goes here
        refreshCorners(value: cornerRadius)
    }
    
    // MARK: Internal Methods
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    
}
