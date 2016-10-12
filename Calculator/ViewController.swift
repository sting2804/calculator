//
//  ViewController.swift
//  Calculator
//
//  Created by Sergey Linnik on 10/12/16.
//  Copyright © 2016 Sergey Linnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    private var calculatorService: CalculatorService = CalculatorService()
    private var userIsInProgress = false
    
    private var displayText: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let currentTitle = display.text!
        if !userIsInProgress {
            display.text = digit
        } else {
            display.text = currentTitle + digit
        }
        userIsInProgress = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInProgress {
            calculatorService.setOperand(operand: displayText)
            userIsInProgress = false
        }
        if let operationType = sender.currentTitle {
            calculatorService.performOperation(symbol: operationType)
        }
        //print(calculatorService.result)
        //displayText = calculatorService.result
    }

}

