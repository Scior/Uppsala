//
//  DialogTexts.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/05.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

public struct DialogTexts {
    
    /// The title of the alert dialog.
    public let title: String
    /// The message of the alert dialog.
    public let message: String
    
    public init(title: String?, message: String?) {
        // TODO: Localize
        
        self.title = title ?? "Update Notification"
        self.message = message ?? "The new version of this app is now available!"
    }
}
