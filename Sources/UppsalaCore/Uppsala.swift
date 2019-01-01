//
//  Uppsala.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 A main class of Uppsala with convenient functions.
 */
public final class Uppsala {
    
    // MARK: - Properties
    
    /// Shared static instance.
    public static let shared = Uppsala(source: EnvironmentSourceApp())
    
    let environment: Environment
    
    // MARK: - Computed properties
    
    /// The short version of the app.
    public var appShortVersion: SemanticVersion? {
        return environment.appShortVersion
    }
    
    // MARK: - Lifecycle
    
    init(source: EnvironmentSource) {
        environment = Environment(source: source)
    }
    
    // MARK: - Methods
    
}
