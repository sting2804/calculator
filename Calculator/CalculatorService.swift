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
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Reset
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryOperation: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "AC": Operation.Reset,
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "±": Operation.UnaryOperation({ -$0 }),
        "×": Operation.BinaryOperation({$0 * $1}),
        "÷": Operation.BinaryOperation({$0 / $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "=": Operation.Equals,
        ".": Operation.BinaryOperation({ Double("\($0).\($1)")! })
    ]

    func performOperation(symbol: String){
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingOperation()
                pending = PendingBinaryOperationInfo(binaryOperation: function, firstOperand: accumulator)
            case .Reset:
                pending = nil
                accumulator = 0.0
            case .Equals:
                executePendingOperation()
            default: break
            }
        }
    }
    
    private func executePendingOperation() {
        if pending != nil {
            accumulator = pending!.binaryOperation(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    
}
