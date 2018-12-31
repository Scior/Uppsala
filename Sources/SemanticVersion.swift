//
//  SemanticVersion.swift
//  Uppsala
//
//  Created by Suita Fujino on 2018/12/31.
//  Copyright © 2018 Suita Fujino. All rights reserved.
//

public class SemanticVersion : Comparable {
    
    public typealias VersionDataType = UInt32
    
    // MARK: - Properties
    
    public var splitVersionNumber: [VersionDataType] = []
    
    public var count: Int {
        return splitVersionNumber.count
    }
    
    // MARK: - Lifecycle
    
    /**
     Failable initializer with parsing string.
     
     - Parameters:
       - str: A string to parse.
     */
    init?(from str: String) {
        var result: [VersionDataType] = []
        
        for splitString in str.split(separator: ".") {
            guard let number = VersionDataType(splitString) else { return nil }
            result.append(number)
        }
        
        splitVersionNumber = result
    }
    
    // MARK: - Methods
    
    subscript(index: Int) -> VersionDataType? {
        guard (0..<splitVersionNumber.count).contains(index) else { return nil }
        return splitVersionNumber[index]
    }
    
    // MARK: - Operators
    
    public static func < (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        let loopLimit = min(lhs.count, rhs.count)
        
        for count in 0..<loopLimit {
            guard let leftNumber = lhs[count], let rightNumber = rhs[count] else { fatalError("Uppsala: Index is out of range") }
            
            if leftNumber == rightNumber {
                continue
            }
            return leftNumber < rightNumber
        }
        
        return false
    }
    
    public static func == (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
        let loopLimit = min(lhs.count, rhs.count)
        
        for count in 0..<loopLimit {
            guard let leftNumber = lhs[count], let rightNumber = rhs[count] else { fatalError("Uppsala: Index is out of range") }
            
            if leftNumber != rightNumber {
                return false
            }
        }
        
        return true
    }
    
}
