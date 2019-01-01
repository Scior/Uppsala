//
//  AlertControllerFactory.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import UIKit

/**
 A factory of `UIAlertController` with the default actions and the complition handler.
 */
public class AlertControllerFactory {
    
    public typealias ComplitionHandler = (UIAlertAction) -> Void
    
    /**
     The default action for the update alert dialog.
     */
    public enum DefaultAction: Hashable {
        /// Opens App Store.
        case openAppStore(title: String, url: URL)
        /// Close the alert dialog.
        case close(title: String)
    }
    
    // MARK: - Properties
    
    /// The title of the alert dialog.
    let title: String?
    /// The message of the alert dialog.
    let message: String?
    
    /// The `Set` of the default action.
    public var actions: Set<DefaultAction> = []
    
    // MARK: - Lifecycle
    
    /**
     Initializer.
     
     - Parameters:
       - title: The title of the alert dialog.
       - message: The message of the alert dialog.
     */
    public init(title: String?, message: String?) {
        self.title = title
        self.message = message
    }
    
    // MARK: - Methods
    
    /**
     Constructs `UIAlertController` with the complition handler.
     
     - Parameters:
       - complition: The complition handler executed after the action ended.
     
     - Returns: `UIAlertController` with the default actions and the complition handler.
     */
    public func build(complition: (ComplitionHandler)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            switch action {
            case .openAppStore(let title, let url):
                let action = UIAlertAction(title: title, style: .default) { action in
                    UIApplication.shared.open(url: url)
                    complition?(action)
                }
                alertController.addAction(action)
            case .close(let title):
                let action = UIAlertAction(title: title, style: .cancel) { action in
                    complition?(action)
                }
                alertController.addAction(action)
            }
        }
        
        return alertController
    }
    
}

fileprivate extension UIApplication {
    func open(url: URL) {
        if #available(iOS 10.0, *) {
            self.open(url)
        } else {
            self.openURL(url)
        }
    }
}
