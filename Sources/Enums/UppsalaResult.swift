//
//  UppsalaResult.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 A class represents the direct sum of the result `T` and the error `E`.
 */
public enum UppsalaResult<T, E> {
    
    /// OK status which has the result value.
    case ok(T)
    /// Error status which has the value describing the occured error.
    case error(E)
    
    /**
     Returns whether the result is OK.
     
     - returns:
       - `true` OK
       - `false` Error
     */
    public func isOk() -> Bool {
        switch self {
        case .ok:
            return true
        case .error:
            return false
        }
    }
    
    /**
     Returns whether the result has some error.
     
     - returns:
       - `true` Error
       - `false` OK
     */
    public func isError() -> Bool {
        return !isOk()
    }
    
    /**
     Returns the result which is wrapped by `Optional`.
     
     - returns: Returns the result which has type `T` if itself is `.ok`. Otherwise, returns `nil`.
     */
    public func ok() -> T? {
        switch self {
        case .ok(let result):
            return result
        case .error:
            return nil
        }
    }
    
    /**
     Returns the error which is wrapped by `Optional`.
     
     - returns: Returns the error which has type `E` if itself is `.error`. Otherwise, returns `nil`.
     */
    public func error() -> E? {
        switch self {
        case .ok:
            return nil
        case .error(let error):
            return error
        }
    }
    
    /**
     Applies the function to convert the result type from `T` to `U`.
     
     - Parameters:
       - transform: A mapper function which maps `T` to `U`.
     
     - returns:
       - `.ok` with type `Result<U, E>`, if its original state was `.ok`.
       - `.error` with type `Result<U, E>`, if its original state was `.error`.
     */
    public func map<U>(_ transform: ((T) -> U)) -> UppsalaResult<U, E> {
        switch self {
        case .ok(let result):
            return .ok(transform(result)) as UppsalaResult<U, E>
        case .error(let error):
            return .error(error) as UppsalaResult<U, E>
        }
    }
    
}
