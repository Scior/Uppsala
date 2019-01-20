//
//  RangeParsable.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/06.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

protocol RangeParsableFactory {
    
    associatedtype ImplType
    
    /**
     Failable intializer from `String`.
     
     - Parameters:
       - str: The characters to parse.
     */
    static func from(_ str: String) -> ImplType?
}

protocol RangeParsable: Comparable, RangeParsableFactory where ImplType == Self {}
