//
//  StringExtensions.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import Foundation
extension String {
    
    /// Return count of substring in a string
    public func count(of string: String) -> Int {
        return components(separatedBy: string).count - 1
    }
    
    /// Return true if String contains another substring
    public func contain(string: String) -> Bool {
        return count(of: self) > 0
    }
    
    /// Return true if String ends with the given substring
    public func end(with suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    /// Return true is String starts with the given substring
    public func start(with prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
    // FIXME: -
    /// Return true if string is empty or contains only spaces or new lines
    public var isEmpty: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count == 0
    }
    
    /// Return an array of Strings by sipliting the given String into another strings
    public func split(by separator: Character) -> [String] {
        return characters.split{$0 == separator}.map(String.init)
    }
    
    /// Return trimmed string (remived spaces and new lines from beginning and end of string)
    public var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    mutating public func trim() {
        self = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// Return first character in a string
    public var firstCharacter: String? {
        return Array(self.characters).map({String($0)}).first
    }
    
    /// Return last character in a string
    public var lastCharacter: String? {
        return Array(self.characters).map({String($0)}).last
    }
    
    /// Return the most common character in a string
    public var mostCommonCharacter: String {
        var mostCommon = ""
        let charSet = Set(self.characters.map{String($0)})
        var count = 0
        for string in charSet {
            if self.count(of: string) > count {
                count = self.count(of: string)
                mostCommon = string
            }
        }
        return mostCommon
    }
    
    /// Separtare new line delimated string into array of strings
    public func lines() -> [String] {
        var result:[String] = []
        enumerateLines { (line, stop) -> () in
            result.append(line)
        }
        return result
    }
    
    /// Return true is string is a valid email format
    var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Return reversed string
    var reversed: String {
        return String(characters.reversed())
    }
    
    mutating func reverse() {
        self = String(characters.reversed())
    }
    
    /// Return the first index of a substring in a string
    public func firstIndex(of string: String) -> Int? {
        return Array(self.characters).map({String($0)}).index(of: string)
    }
    
    /// Replace part of string with another string
    public func replace(string: String, with: String) -> String {
        return self.replacingOccurrences(of: string, with: with)
    }
    
    /// Pretty prints the json for ease of read
    static func prettyPrintJson(object: AnyObject?) -> String {
        var prettyResult: String = ""
        if object == nil {
            return ""
        } else if let resultArray = object as? [AnyObject] {
            var entries: String = ""
            for index in 0..<resultArray.count {
                if (index == 0) {
                    entries = "\(resultArray[index])"
                } else {
                    entries = "\(entries), \(prettyPrintJson(object: resultArray[index]))"
                }
            }
            prettyResult = "[\(entries)]"
        } else if object is NSDictionary  {
            let objectAsDictionary: [String: AnyObject] = object as! [String: AnyObject]
            prettyResult = "{"
            var entries: String = ""
            for (key,_) in objectAsDictionary {
                entries = "\"\(entries), \"\(key)\":\(prettyPrintJson(object: objectAsDictionary[key]))"
            }
            prettyResult = "{\(entries)}"
            return prettyResult
        } else if let objectAsNumber = object as? NSNumber {
            prettyResult = "\(objectAsNumber.stringValue)"
        } else if let objectAsString = object as? NSString {
            prettyResult = "\"\(objectAsString)\""
        }
        return prettyResult
    }
    
}
