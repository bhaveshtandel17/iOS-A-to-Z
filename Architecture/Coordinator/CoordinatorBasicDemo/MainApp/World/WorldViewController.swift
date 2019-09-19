//
//  WorldViewController.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 29/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class WorldViewController: UIViewController {

    internal var showHeadlineForCountry: ((_ code: String) -> Void) = {_ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func countrySelected(_ sender: UIButton) {
        var code = ""
        switch sender.tag {
        case 1:
          code = "in"
        case 2:
            code = "pk"
        case 3:
            code = "cn"
        case 4:
            code = "ru"
        case 5:
            code = "us"
        case 6:
            code = "uk"
        default:
            code = ""
        }
        self.showHeadlineForCountry(code)
    }

}
