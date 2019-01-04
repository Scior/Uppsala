//
//  UpdateDetail.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/02.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

public struct UpdateDetail: Decodable {
    let version: String
}

extension UpdateDetail {
    /**
     The static factory of `UpdateDetail`.
     
     - Parameters:
       - data: The `Data` to be converted.
     
     - Throws: `Error` from `JSONDecoder`.
     - Returns: `UpdateDetail`.
     */
    public static func from(data: Data) throws -> UpdateDetail {
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch let error {
            throw error
        }
    }
}
