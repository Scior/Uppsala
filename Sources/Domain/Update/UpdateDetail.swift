//
//  UpdateDetail.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/05.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 An entity class which describes the update information.
 */
public final class UpdateDetail {
    
    public enum ConversionError: Error {
        case failedToConvert(Any)
    }
    
    /// The URL for App Store.
    public let appStoreUrl: URL
    
    /// The message of the alert dialog.
    public let message: String?
    
    /// The title of the alert dialog.
    public let title: String?
    
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
        guard let appStoreUrl = URL(string: entity.appStoreUrl) else { throw ConversionError.failedToConvert(entity.appStoreUrl) }
        guard let version = parser.parse(from: entity.version).ok() else { throw ConversionError.failedToConvert(entity.version) }
        
        self.appStoreUrl = appStoreUrl
        self.message = entity.message
        self.title = entity.title
        self.version = version
    }
    
    // MARK: - Methods
    
}
