//
//  String+match.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

internal extension String {
    /**
     Counts the number of matches with the given regex.
     
     - Parameters:
       - regex: The regex used for matching.
     
     - Returns: The number of matches, or `nil` when the invalid regex is given.
     */
    func match(regex: String) -> Int? {
        guard let regex = try? NSRegularExpression(pattern: regex) else { return nil }
        return regex.numberOfMatches(in: self, range: NSRange(location: 0, length: count))
    }
}
