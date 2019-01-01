//
//  EnvironmentSourceApp.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

class EnvironmentSourceApp: EnvironmentSource {
    func fetchShortVersion() -> String? {
        return Bundle.main.shortVersion
    }
}
