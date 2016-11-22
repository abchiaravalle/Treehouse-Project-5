//
//  ViewController.swift
//  PassGenerator - Treehouse Project 4
//
//  Created by Adam Chiaravalle on 11/22/16.
//  Copyright © 2016 Adam Chiaravalle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a pass generator and run tests
        let pg = PassGenerator()
        pg.generateAndRunTests()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

