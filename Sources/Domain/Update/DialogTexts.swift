//
//  DialogTexts.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/05.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 A data class to hold the messages for the alert dialog.
 */
public struct DialogTexts {
    
    /// The title of the alert dialog.
    public let title: String
    /// The message of the alert dialog.
    public let message: String
    
    /**
     Initializer.
     
     - Parameters:
       - title: The title of the dialog. `nil` will be replaced with the default text.
       - message: The message of the dialog. `nil` will be replaced with the default text.
     */
    public init(title: String?, message: String?) {
        // TODO: Localize
        
        self.title = title ?? "Update Notification"
        self.message = message ?? "The new version of this app is now available!"
    }
}
