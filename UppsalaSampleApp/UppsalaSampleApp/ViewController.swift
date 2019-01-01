//
//  ViewController.swift
//  UppsalaSampleApp
//
//  Created by Suita Fujino on 2019/01/01.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

import UIKit
import Uppsala

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(Uppsala.shared.appShortVersion)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let url = URL(string: "https://www.google.com/") else { return }
        let factory = AlertControllerFactory(
            title: "Update Notification",
            message: "The new version of this app is now available!"
        )
        factory.actions = [.close(title: "Close"), .openAppStore(title: "App Store", url: url)]
        let alertController = factory.build(complition: { action in
            print("Dismissed: \(action)")
        })
        
        present(alertController, animated: true, completion: nil)
    }

}
