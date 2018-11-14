//
//  HTMLStringDecodeExtension.swift
//  RedditRealTime
//
//  Created by Daniel Yount on 11/13/18.
//  Copyright © 2018 Daniel Yount. All rights reserved.
//

import Foundation

extension String {
    func removeHTMLEntities() -> NSAttributedString? {
        
        let data = self.data(using: .utf8)
        
        let options : [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: data!, options: options, documentAttributes: nil)
            return attributedString
        } catch {
            print(error)
        }
        
        return nil
    }
}
