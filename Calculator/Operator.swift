//
//  Operator.swift
//  Calculator
//
//  Created by Scott Zhu on 2/5/16.
//  Copyright © 2016 Scott Zhu. All rights reserved.
//

import UIKit

enum OperatorType: String {
    case Percentage = "%",
    Divide = "÷",
    Multiply = "x",
    Add = "+",
    Minus = "-",
    Equal = "="
}

class Operator: NSObject {
    var myOperator: OperatorType
    
    init(withType type: OperatorType) {
        self.myOperator = type
    }
}
