//
//  Environment.swift
//  Uppsala
//
//  Created by Suita Fujino on 2018/12/31.
//  Copyright © 2018 Suita Fujino. All rights reserved.
//

final class Environment {
    
    // MARK: - Properties
    
    /// The short version fetched from app.
    let appShortVersion: SemanticVersion?
    
    // MARK: - Lifecycle
    
    /**
     Intializer with `EnvironmentSource`.
     
     - Parameters:
       - source: The source from which the app infomation is fetched.
     */
    init(source: EnvironmentSource) {
        appShortVersion = source.fetchShortVersion().flatMap({ SemanticVersion(from: $0) })
    }
    
    // MARK: - Methods
    
}
