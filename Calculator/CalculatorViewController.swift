//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Scott Zhu on 2/2/16.
//  Copyright © 2016 Scott Zhu. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    enum Operator: Int {
        case Percentage, Divide, Multiply, Add, Minus, Equal
    }
    
    @IBOutlet weak var screenLabel: UILabel!
    
    var arrayAsStack = [AnyObject]()

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
        if screenLabel.text == "0" && (sender.titleForState(UIControlState.Normal) ?? "") != "." {
            screenLabel.text = ""
        }
        if (screenLabel.text ?? "").containsString(".") && (sender.titleForState(UIControlState.Normal) ?? "") == "." {
            return
        }
        screenLabel.text?.appendContentsOf(sender.titleForState(UIControlState.Normal) ?? "")
//        if let lastObjectInStack = arrayAsStack.last as? Operator {
//            
//        } else if let lastObjectInStack = arrayAsStack.last as? NSNumber {
//            
//        }
    }
    
    @IBAction func ACTapped(sender: UIButton) {
        screenLabel.text = "0"
        arrayAsStack = []
    }
}
