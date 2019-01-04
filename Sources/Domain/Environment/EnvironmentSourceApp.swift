//
//  EnvironmentSourceApp.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 A source fetching version information from app bundle.
 */
class EnvironmentSourceApp: EnvironmentSource {
    func fetchShortVersion() -> String? {
        return Bundle.main.shortVersion
    }
}
