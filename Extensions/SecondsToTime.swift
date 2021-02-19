//
//  SecondsToTime.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 16.02.21.
//

import Foundation

extension Int {
    
    func secondsToTime() -> String {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        guard let formattedString = formatter.string(from: TimeInterval(self)) else {
            return ""
        }
        return formattedString
    }
}
