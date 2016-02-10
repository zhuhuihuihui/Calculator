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
    
    var arrayAsStack = [AnyObject]()
    var isUserEndTyping = false
    var tempNum: NSNumber?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func negativeTapped(sender: UIButton) {
        if let numberString = screenLabel.text, number = numberString.numberValue() where number.doubleValue != 0 {
            if let resultNum = "\(number.doubleValue * -1)".numberValue() {
                screenLabel.text = resultNum.stringValue
                if isUserEndTyping {
                    arrayAsStack[0] = resultNum
                }
            }
        }
    }
    
    @IBAction func percentageTapped(sender: UIButton) {
        if let numberString = screenLabel.text, number = numberString.numberValue() where number.doubleValue != 0 {
            if let resultNum = "\(number.doubleValue * 0.01)".numberValue() {
                screenLabel.text = resultNum.stringValue
                if isUserEndTyping {
                    arrayAsStack[0] = resultNum
                }
            }
        }
    }
    
    @IBAction func operatorTapped(sender: UIButton) {
        if let _ = arrayAsStack.last as? Operator {
            if let operatorType = OperatorType(rawValue: sender.titleForState(UIControlState.Normal) ?? "") {
                if isUserEndTyping && operatorType != .Equal {
                    arrayAsStack.removeLast()
                    arrayAsStack.append(Operator(withType: operatorType))
                } else if isUserEndTyping && operatorType == .Equal {
                    /**1 Get number from the screen.*/
                    if let tempNum = tempNum {
                        arrayAsStack.append(tempNum)
                        /**2. Calculate the first three in the stack*/
                        if let rightNum = arrayAsStack.popLast() as? NSNumber, myOperator = arrayAsStack.popLast() as? Operator, leftNum = arrayAsStack.popLast() as? NSNumber {
                            switch myOperator.myOperator {
                            case OperatorType.Add:
                                if let resultNum = "\(leftNum.doubleValue + rightNum.doubleValue)".numberValue() {
                                    screenLabel.text = resultNum.stringValue
                                    arrayAsStack.append(resultNum)
                                    arrayAsStack.append(Operator(withType: operatorType))
                                }
                                break
                            case OperatorType.Minus:
                                if let resultNum = "\(leftNum.doubleValue - rightNum.doubleValue)".numberValue() {
                                    screenLabel.text = resultNum.stringValue
                                    arrayAsStack.append(resultNum)
                                    arrayAsStack.append(Operator(withType: operatorType))
                                }
                                break
                            case OperatorType.Multiply:
                                if let resultNum = "\(leftNum.doubleValue * rightNum.doubleValue)".numberValue() {
                                    screenLabel.text = resultNum.stringValue
                                    arrayAsStack.append(resultNum)
                                    arrayAsStack.append(Operator(withType: operatorType))
                                }
                                break
                            case OperatorType.Divide:
                                if rightNum.doubleValue == 0 {
                                    arrayAsStack.removeAll()
                                    screenLabel.text = "0"
                                    return
                                }
                                if let resultNum = "\(leftNum.doubleValue / rightNum.doubleValue)".numberValue() {
                                    screenLabel.text = resultNum.stringValue
                                    arrayAsStack.append(resultNum)
                                    arrayAsStack.append(Operator(withType: operatorType))
                                }
                                break
                            default:
                                break
                            }
                            if operatorType == OperatorType.Equal && arrayAsStack.count > 0 {
                                arrayAsStack.removeLast()
                                arrayAsStack.append(myOperator)
                            }
                        }
                        return
                    }
                } else {
                    /**1 Get number from the screen.*/
                    if let numberString = screenLabel.text {
                        if let number = numberString.numberValue() {
                            arrayAsStack.append(number)
                            /**2. Calculate the first three in the stack*/
                            if let rightNum = arrayAsStack.popLast() as? NSNumber, myOperator = arrayAsStack.popLast() as? Operator, leftNum = arrayAsStack.popLast() as? NSNumber {
                                if operatorType == OperatorType.Equal {
                                    tempNum = number
                                }
                                
                                switch myOperator.myOperator {
                                case OperatorType.Add:
                                    if let resultNum = "\(leftNum.doubleValue + rightNum.doubleValue)".numberValue() {
                                        screenLabel.text = resultNum.stringValue
                                        arrayAsStack.append(resultNum)
                                        arrayAsStack.append(Operator(withType: operatorType))
                                    }
                                    break
                                case OperatorType.Minus:
                                    if let resultNum = "\(leftNum.doubleValue - rightNum.doubleValue)".numberValue() {
                                        screenLabel.text = resultNum.stringValue
                                        arrayAsStack.append(resultNum)
                                        arrayAsStack.append(Operator(withType: operatorType))
                                    }
                                    break
                                case OperatorType.Multiply:
                                    if let resultNum = "\(leftNum.doubleValue * rightNum.doubleValue)".numberValue() {
                                        screenLabel.text = resultNum.stringValue
                                        arrayAsStack.append(resultNum)
                                        arrayAsStack.append(Operator(withType: operatorType))
                                    }
                                    break
                                case OperatorType.Divide:
                                    if rightNum.doubleValue == 0 {
                                        arrayAsStack.removeAll()
                                        screenLabel.text = "0"
                                        return
                                    }
                                    if let resultNum = "\(leftNum.doubleValue / rightNum.doubleValue)".numberValue() {
                                        screenLabel.text = resultNum.stringValue
                                        arrayAsStack.append(resultNum)
                                        arrayAsStack.append(Operator(withType: operatorType))
                                    }
                                    break
                                default:
                                    break
                                }
                                if operatorType == OperatorType.Equal && arrayAsStack.count > 0 {
                                    arrayAsStack.removeLast()
                                    arrayAsStack.append(myOperator)
                                }
                            }
                        }
                    }
                }
            }
        } else if let _ = arrayAsStack.last as? NSNumber {
            
        } else {
            //Nothing in the Stack
            if let numberString = screenLabel.text, operatorType = OperatorType(rawValue: sender.titleForState(UIControlState.Normal) ?? "") where arrayAsStack.isEmpty {
                let numberFormatter = NSNumberFormatter()
                numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
                if let number = numberFormatter.numberFromString(numberString) {
                    arrayAsStack.append(number)
                    arrayAsStack.append(Operator(withType: operatorType))
                    tempNum = number
                }
            }
        }
        isUserEndTyping = true
    }
    
    @IBAction func numberTapped(sender: UIButton) {
        if isUserEndTyping {
            self.screenLabel.text = (sender.titleForState(UIControlState.Normal) ?? "") == "." ? "0" : ""
            isUserEndTyping = false
            tempNum = nil
        }
        
        if screenLabel.text == "0" && (sender.titleForState(UIControlState.Normal) ?? "") != "." {
            screenLabel.text = ""
        }
        if (screenLabel.text ?? "").containsString(".") && (sender.titleForState(UIControlState.Normal) ?? "") == "." {
            return
        }
        screenLabel.text?.appendContentsOf(sender.titleForState(UIControlState.Normal) ?? "")
    }
    
    @IBAction func ACTapped(sender: UIButton) {
        screenLabel.text = "0"
        arrayAsStack = []
    }
}

extension String {
    func numberValue() -> NSNumber? {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        return numberFormatter.numberFromString(self)
    }
}
