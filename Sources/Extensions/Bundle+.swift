//
//  Bundle+.swift
//  Uppsala
//
//  Created by Suita Fujino on 2018/12/31.
//  Copyright © 2018 Suita Fujino. All rights reserved.
//

extension Bundle {
    /// The shorthand to access the `Bundle` for `Uppsala`.
    static var uppsala: Bundle? {
        return Bundle(identifier: "com.flyingalpaca.Uppsala")
    }
    
    /// The short version of app.
    var shortVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
