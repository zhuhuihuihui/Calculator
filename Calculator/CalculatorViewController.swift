//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Scott Zhu on 2/2/16.
//  Copyright © 2016 Scott Zhu. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var screenLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func numberTapped(sender: UIButton) {
    }
}
