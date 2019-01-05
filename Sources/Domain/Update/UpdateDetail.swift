//
//  UpdateDetail.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/05.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

public class UpdateDetail {
    
    public enum ConversionError: Error {
        case failedToConvert(Any)
    }
    
    /// The range of the app version to update.
    public let version: Range<SemanticVersion>
    
    // MARK: - Lifecycle
    
    /**
     Throwable initializer with `UpdateDetailJSONEntity`.
     
     - Parameters:
       - entity: The entity to convert.
     
     - throws: `ConversionError`
     */
    init(from entity: UpdateDetailJSONEntity, parser: SemanticVersionRangeParser = SemanticVersionRangeParser()) throws {
        guard let version = parser.parse(from: entity.version).ok() else { throw ConversionError.failedToConvert(entity.version) }
        
        self.version = version
    }
    
    // MARK: - Methods
    
}
