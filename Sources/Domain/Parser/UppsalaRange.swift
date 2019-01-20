//
//  UppsalaRange.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/20.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

public final class UppsalaRange<T: Comparable> {
    
    // MARK: - Properties
    
    /// The left side value of the range.
    public let left: T?
    /// The right side value of the range.
    public let right: T?
    
    /// Whether the right side value is contained.
    public let isContainingRightSide: Bool
    
    // MARK: - Lifecycle
    
    /**
     Initializer.
     
     - Parameters:
       - lhs: The left side of the range.
       - rhs: The right side of the range.
       - isContainingRightSide: Whether the right side value is contained.
     */
    public init(lhs: T? = nil, rhs: T? = nil, isContainingRightSide: Bool = true) {
        left = lhs
        right = rhs
        self.isContainingRightSide = isContainingRightSide
    }
    
    // MARK: - Methods
    
    /**
     Returns whether the range contains the target value.
     
     - Parameters:
       - target: The target value.
     
     - Returns: Whether the range contains the target value.
     */
    public func contains(_ target: T) -> Bool {
        switch (left, right, isContainingRightSide) {
        case (.some(let left), .some(let right), true):
            return (left...right).contains(target)
        case (.some(let left), .some(let right), false):
            return (left..<right).contains(target)
        case (.some(let left), .none, _):
            return (left...).contains(target)
        case (.none, .some(let right), true):
            return (...right).contains(target)
        case (.none, .some(let right), false):
            return (..<right).contains(target)
        case (.none, .none, _):
            return true
        }
    }
    
}

extension UppsalaRange: Equatable {
    public static func == (lhs: UppsalaRange<T>, rhs: UppsalaRange<T>) -> Bool {
        return lhs.left == rhs.left && lhs.right == rhs.right && lhs.isContainingRightSide == rhs.isContainingRightSide
    }
}
