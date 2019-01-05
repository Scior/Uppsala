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
    
    let testURL = Bundle.main.url(forResource: "update_detail", withExtension: "json")!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(Uppsala.shared.appShortVersion?.description)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let detail = Uppsala.shared.fetchAwait(from: testURL).ok() else { return }
        
        present(AlertControllerFactory.from(updateDetail: detail), animated: true, completion: nil)
    }

}
