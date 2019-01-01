//
//  Environment.swift
//  Uppsala
//
//  Created by Suita Fujino on 2018/12/31.
//  Copyright © 2018 Suita Fujino. All rights reserved.
//

final class Environment {
    
    // MARK: - Properties
    
    let appShortVersion: SemanticVersion?
    
    // MARK: - Lifecycle
    
    /**
     Intializer with `EnvironmentSource`.
     
     - Parameters:
       - source: The source from which the app infomation is fetched.
     */
    init(source: EnvironmentSource) {
        if let shortVersion = source.fetchShortVersion() {
            appShortVersion = SemanticVersion(from: shortVersion)
        } else {
            appShortVersion = nil
        }
    }
    
    // MARK: - Methods
    
}
