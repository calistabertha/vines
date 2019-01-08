//
//  UIKit+Extension.swift
//  Vines
//
//  Created by Calista Bertha on 27/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

extension Date {
    func toMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    func currentDate(formatString: String? = "dd MMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter.string(from: self)
    }
    
    func hoursMinuteConverter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func getStringDate(formatString: String? = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        return formatter.string(from: self)
    }
}

extension String {
    func convertToTimestamp(withFormatString string: String? = "dd-MM-yyyy") -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = string
        let date = dateFormatter.date(from: self)
        let dateStamp: TimeInterval = (date?.timeIntervalSince1970)!
        return dateStamp
    }
  
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    
    private var length: Int {
        return self.count
    }
    
    func getBithdateString(formatString: String? = "dd MMMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from:self) else {
            return ""
        }
        formatter.dateFormat = formatString
        return formatter.string(from: date)
    }
    
    func convertToDate(formatString: String? = "dd MMMM yyyy") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        
        let date = dateFormatter.date(from: self)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date ?? Date())
        return calendar.date(from: components) ?? Date()
    }
    
}
