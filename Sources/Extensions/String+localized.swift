//
//  String+localized.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/02/02.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

extension String {
    /**
     Returns the localized string using the `self` value as a key.
     
     - Returns: The localized string.
     */
    func localized() -> String {
        guard let bundle = Bundle.uppsala else { return self }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: self)
    }
}
