//
//  AlertControllerFactory.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import UIKit

/**
 A factory of `UIAlertController` with the default actions and the completion handler.
 
 - Sample code:
 ```
 let factory = AlertControllerFactory(
    title: "Update Notification",
    message: "The new version of this app is now available!"
 )
 factory.actions = [.close(title: "Close"), .openAppStore(title: "App Store", url: url)]
 let alertController = factory.build()
 
 present(alertController, animated: true, completion: nil)
 ```
 */
public final class AlertControllerFactory {
    
    public typealias CompletionHandler = (DefaultAction, UIAlertAction) -> Void
    
    /**
     The default action for the update alert dialog.
     */
    public enum DefaultAction: Hashable {
        /// Opens App Store.
        case openAppStore(title: String, url: URL)
        /// Opens an external link.
        case openLink(title: String, url: URL)
        /// Close the alert dialog.
        case close(title: String)
    }
    
    // MARK: - Properties
    
    public let texts: DialogTexts
    
    /// The `Set` of the default action.
    public var actions: Set<DefaultAction> = []
    
    // MARK: - Lifecycle
    
    /**
     Initializer.
     
     - Parameters:
       - texts: Texts for the alert dialog.
     */
    public init(texts: DialogTexts) {
        self.texts = texts
    }
    
    // MARK: - Methods
    
    /**
     Constructs `UIAlertController` with the completion handler.
     
     - Parameters:
       - completion: The completion handler executed after the action ended.
     
     - Returns: `UIAlertController` with the default actions and the completion handler.
     */
    public func build(completion: (CompletionHandler)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: texts.title, message: texts.message, preferredStyle: .alert)
        
        for action in actions {
            switch action {
            case .openAppStore(let title, let url):
                alertController.addDefaultAction(title: title, style: .default, defaultAction: action, completion: completion) {
                    UIApplication.shared.open(url: url)
                }
            case .openLink(let title, let url):
                alertController.addDefaultAction(title: title, style: .default, defaultAction: action, completion: completion) {
                    UIApplication.shared.open(url: url)
                }
            case .close(let title):
                alertController.addDefaultAction(title: title, style: .cancel, defaultAction: action, completion: completion)
            }
        }
        
        return alertController
    }
    
    public class func from(updateDetail: UpdateDetail) -> UIAlertController {
        let factory = AlertControllerFactory(texts: DialogTexts(
            title: updateDetail.title,
            message: updateDetail.message
        ))
        factory.actions = [.close(title: "Close"), .openAppStore(title: "App Store", url: updateDetail.appStoreUrl)]
        
        return factory.build()
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

fileprivate extension UIAlertController {
    /**
     Adds the default action to `UIAlertController`.
     
     - Parameters:
       - title: The title of the alert dialog.
       - style: `UIAlertAction.Style`
       - defaultAction: The type of the action.
       - completion: The handler which is called when the alert dialog dismisses.
       - handler: The handler which dedcribes the action corresponding with the default action.
     */
    func addDefaultAction(title: String?, style: UIAlertAction.Style, defaultAction: AlertControllerFactory.DefaultAction, completion: AlertControllerFactory.CompletionHandler?, handler: (() -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: style) { action in
            handler?()
            completion?(defaultAction, action)
        }
        self.addAction(action)
    }
}
