//
//  CalculatorService.swift
//  Calculator
//
//  Created by Sergey Linnik on 10/12/16.
//  Copyright © 2016 Sergey Linnik. All rights reserved.
//

import Foundation

class CalculatorService {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    func performOperation(symbol: String){
        switch symbol {
        case "CE":
            accumulator = 0
        case "π":
            accumulator = M_PI
        case "√":
            accumulator = sqrt(accumulator)
        default:
            break
        }
    
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
}
