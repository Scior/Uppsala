//
//  Date+RangeParsable.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/06.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 A model class which describes a notificarion date.
 */
extension Date: RangeParsable {
    
    // (InheritDoc)
    static func from(_ str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.locale = Locale.current
        
        return dateFormatter.date(from: str)
    }
    
}
