//
//  SemanticVersionRangeParser.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 A parser for the semi-open range of `SemanticVersion`.
 */
public final class SemanticVersionRangeParser {
    
    public typealias Result = UppsalaResult<Range<SemanticVersion>, ParseError>
    
    /// Error occurred on parsing.
    public enum ParseError: Error {
        /// Invalid input format. (e.g. Invalid characters.)
        case invalidFormat(String)
        /// Invalid version format. (e.g. 0.1..2)
        case invalidVersionFormat(String)
    }
    
    // MARK: - Methods
    
    /**
     Parses from the given pattern to the semi-open range of `SemanticVersion`.
     
     NOTE: The pattern which confirms to `^[0-9.<]+[0-9]+$` is acceptable.
     ```
     0.0<1.1.2 // acceptable
     <1.1.2 // accetable
     1.1.2 // acceptable (and equivalent to 1.1.2<1.1.2.1)
     1.1.2< // NOT acceptable
     <=1.1.2 // NOT acceptable
     ```
     
     - Parameters:
       - str: The pattern represents the semi-open range.
     
     - Returns: The combined `Result` of Range<SemanticVersion> and `ParseError`.
     */
    public class func parse(from str: String) -> Result {
        let pattern = "0" + str.replacingOccurrences(of: " ", with: "")
        guard pattern.isMatching(regex: "^[0-9.<]+[0-9]+$") else { return .error(.invalidFormat(pattern)) }
        
        var split = pattern.split(separator: "<")
        switch split.count {
        case 1:
            split += [split[0] + ".1"]
        case 2:
            break
        default:
            return .error(.invalidFormat(str))
        }
        
        let range = split.compactMap({ SemanticVersion(from: String($0)) })
        if range.count != 2 {
            return .error(.invalidVersionFormat(str))
        }
        
        return Result.ok(range[0]..<range[1])
    }
}
