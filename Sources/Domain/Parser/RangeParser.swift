//
//  RangeParser.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 A parser for the semi-open range `String`s.
 */
final class RangeParser {
    
    /// Error occurred on parsing.
    public enum ParseError: Error {
        /// Invalid range format. (e.g. 0.1<)
        case invalidRangeFormat(String)
        /// Invalid value format. (e.g. 0.1..2<1.2)
        case invalidValueFormat(String)
    }
    
    // MARK: - Methods
    
    /**
     Parses from the given pattern to the semi-open range of `T: RangeParsable`.
     
     Here the example with `SemanticVersion`
     ```
     0.1<1.1.2 // acceptable
     0.1<=1.1.2 // acceptable
     <=1.1.2 // acceptable
     <1.1.2 // accetable
     =1.1.2 // accetable
     1.1.2 // acceptable (and equivalent to =1.1.2)
     1.1.2< // NOT acceptable
     ```
     
     - Parameters:
       - str: The pattern represents the semi-open range.
     
     - Returns: The combined `Result` of Range<T> and `ParseError`.
     */
    func parse<T: RangeParsable>(from str: String, to: T.Type) -> UppsalaResult<UppsalaRange<T>, ParseError> {
        let pattern = str.remove(" ")
        guard pattern.isMatching(regex: "^[^<=]*[<]?[=]?[^<=]+$") else { return .error(.invalidRangeFormat(pattern)) }
        
        let split = pattern.remove("=").split(separator: "<")
        
        switch (split.count, pattern.contains("<"), pattern.contains("=")) {
        case (1, true, true):
            guard let rhs = T.from(String(split[0])) else { return .error(.invalidValueFormat(str)) }
            return .ok(UppsalaRange(lhs: nil, rhs: rhs, isContainingRightSide: true))
        case (1, true, false):
            guard let rhs = T.from(String(split[0])) else { return .error(.invalidValueFormat(str)) }
            return .ok(UppsalaRange(lhs: nil, rhs: rhs, isContainingRightSide: false))
        case (1, false, _):
            guard let value = T.from(String(split[0])) else { return .error(.invalidValueFormat(str)) }
            return .ok(UppsalaRange(lhs: value, rhs: value, isContainingRightSide: true))
        case (2, _, _):
            guard let lhs = T.from(String(split[0])), let rhs = T.from(String(split[1])) else { return .error(.invalidValueFormat(str)) }
            return .ok(UppsalaRange(lhs: lhs, rhs: rhs, isContainingRightSide: pattern.contains("=")))
        default:
            return .error(.invalidRangeFormat(str))
        }
    }
}

fileprivate extension String {
    func remove(_ str: String) -> String {
        return self.replacingOccurrences(of: str, with: "")
    }
}
