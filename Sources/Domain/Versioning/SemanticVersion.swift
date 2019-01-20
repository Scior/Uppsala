//
//  SemanticVersion.swift
//  Uppsala
//
//  Created by Suita Fujino on 2018/12/31.
//  Copyright © 2018 Suita Fujino. All rights reserved.
//

/**
 A model class which describes a semantic version.
 */
public class SemanticVersion: Comparable, CustomStringConvertible, RangeParsable {
    
    public typealias VersionDataType = UInt32
    
    // MARK: - Properties
    
    /// The array of split number.
    public var splitVersionNumber: [VersionDataType] = []
    
    /// The number of elements in `splitVersionNumber`.
    public var count: Int {
        return splitVersionNumber.count
    }
    
    // (InheritDoc)
    public var description: String {
        return splitVersionNumber.map({ String($0) }).joined(separator: ".")
    }
    
    // MARK: - Lifecycle
    
    /**
     Failable initializer with parsing string.
     
     - Parameters:
       - str: The characters to parse.
     */
    required public init?(from str: String) {
        var result: [VersionDataType] = []
        if str.isEmpty {
            splitVersionNumber = [0]
            return
        }
        guard let count = str.match(regex: "^(\\d+\\.)*\\d+$"), count > 0 else { return nil }
        
        for splitString in str.split(separator: ".") {
            guard let number = VersionDataType(splitString) else { return nil }
            result.append(number)
        }
        
        splitVersionNumber = result
    }
    
    // MARK: - Methods
    
    class func from(_ str: String) -> SemanticVersion? {
        return SemanticVersion(from: str)
    }

}

extension SemanticVersion {
    
    // MARK: Operators
    
    public subscript(index: Int) -> VersionDataType? {
        guard (0..<splitVersionNumber.count).contains(index) else { return nil }
        return splitVersionNumber[index]
    }
    
    public static func < (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        let loopLimit = max(lhs.count, rhs.count)
        
        for count in 0..<loopLimit {
            let leftNumber = lhs[count] ?? 0
            let rightNumber = rhs[count] ?? 0
            if leftNumber == rightNumber { continue }
            
            return leftNumber < rightNumber
        }
        
        return false
    }
    
    public static func == (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        let loopLimit = max(lhs.count, rhs.count)
        
        for count in 0..<loopLimit {
            let leftNumber = lhs[count] ?? 0
            let rightNumber = rhs[count] ?? 0
            
            if leftNumber != rightNumber {
                return false
            }
        }
        
        return true
    }
    
}
