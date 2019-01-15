//
//  StringExtension.swift
//  Vines
//
//  Created by Patrick Marshall on 31/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import Foundation

extension Data {
    public var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    public var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func getValue() -> Int {
        var value = components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        if value == "" {
            value = "0"
        }
        return Int(value)!
    }
    
    func asRupiah() -> String {
        var result: String = ""
        let price = self.getValue().toDouble() as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        formatter.usesGroupingSeparator = true
        formatter.currencyGroupingSeparator = "."
        formatter.currencySymbol = "\(formatter.currencySymbol!) "
        
        if let formatted = formatter.string(from: price) {
            result = formatted
        }
        return result
    }
    
    public var htmlToAttributedString: NSAttributedString? {
        return Data(utf8).htmlToAttributedString
    }
    public var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension Int {
    func toString() -> String {
        return String(self)
    }
    func toDouble() -> Double {
        return Double(self)
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
