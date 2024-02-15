//
//  String+Ext.swift
//  RickAndMorty
//
//  Created by ARDA BUYUKHATIPOGLU on 15.02.2024.
//

import Foundation

extension String {
    
    // Formats an ISO 8601 date string into a human-readable date string.
    ///
    /// - Returns: A formatted date string in the format "MMM d, yyyy", or nil if the input string is not in ISO 8601 format or cannot be converted to a date.
    ///
    /// - Note: The input date string should be in the format "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'".
    func formatDateFromISOToString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = formatter.date(from: self) else {
            print("Failed to convert string to date")
            return nil
        }
        
        //Change formatter to output mode
        formatter.dateFormat = "MMM d, yyyy"
        formatter.timeZone = .current
        
        return formatter.string(from: date)
    }
    
}
