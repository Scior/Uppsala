//
//  EnvironmentSource.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 A protocol represents the source of the enviroment infomation.
 */
protocol EnvironmentSource {
    /**
     Rerturns the short version stirng.
     
     - Returns: The short version of app.
     */
    func fetchShortVersion() -> String?
}
