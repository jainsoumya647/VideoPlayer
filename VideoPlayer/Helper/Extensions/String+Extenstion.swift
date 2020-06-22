//
//  String+Extenstion.swift
//  BookMyShow
//
//  Created by Soumya Jain on 21/04/20.
//  Copyright © 2020 Soumya Jain. All rights reserved.
//

import UIKit

extension String {
    fileprivate var skipTable: [Character: Int] {
        var skipTable: [Character: Int] = [:]
        for (i, c) in enumerated() {
            skipTable[c] = count - i - 1
        }
        return skipTable
    }
    
    fileprivate func match(from currentIndex: Index, with pattern: String) -> Bool {
        if currentIndex < startIndex { return false }
        if currentIndex >= endIndex { return false }
        
        if self[currentIndex] != pattern.last { return false }
        
        if pattern.count == 1 && self[currentIndex] == pattern.last { return true }
        return match(from: index(before: currentIndex), with: "\(pattern.dropLast())")
    }
    
    func isExits(in patterns: [String]) -> Bool {
        
        var isAllPatternsFound = true
        for pattern in patterns {
            let patternLength = pattern.count
            if patternLength == 0 {continue}
            guard patternLength <= count else { return false }
            let skipTable = pattern.skipTable
            let lastChar = pattern.last!
            
            var i = index(startIndex, offsetBy: patternLength - 1)
            var isFound = false
            while i < endIndex {
                let c = self[i]
                if c == lastChar {
                    if match(from: i, with: pattern) {
                        isFound = true
                        break
                    } else {
                        i = index(after: i)
                    }
                } else {
                    i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
                }
            }
            isAllPatternsFound = isAllPatternsFound && isFound
            if !isAllPatternsFound {
                break
            }
        }
        return isAllPatternsFound
    }
}
