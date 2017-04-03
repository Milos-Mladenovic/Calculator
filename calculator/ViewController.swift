//
//  ViewController.swift
//  calculator
//
//  Created by Milos Mladenovic on 12/19/16.
//  Copyright © 2016 Milos Mladenovic. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
 
    @IBOutlet weak var outputlabl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    enum Operation: String {
       case  Divide  = "/"
       case  Multiply = "*"
       case  Substract = "-"
       case  Add = "+"
       case  Empty = "Empty"
    }
    
     var currentOperation = Operation.Empty
     override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
      outputlabl.text = "0"
    }
    @IBAction func numberpressed(sender: UIButton ){
        btnSound.play()
        runningNumber += "\(sender.tag)"
        outputlabl.text = runningNumber
    }
    @IBAction func AddBtnPressed(_ sender: Any) {
        operationProcess(operation: .Add)
    }
    @IBAction func SubstractBtnPressed(_ sender: Any) {
        operationProcess(operation: .Substract)
    }
    @IBAction func MultiplyBtnPressed(_ sender: Any) {
        operationProcess(operation: .Multiply)
    }
    @IBAction func DivideBtnPressed(_ sender: Any) {
        operationProcess(operation: .Divide)
    }
    @IBAction func EqualBtnPressed(_ sender: Any) {
        operationProcess(operation: currentOperation)
    }
    @IBAction func ClearBtn(_ sender: Any) {
        currentOperation = Operation.Empty
        outputlabl.text = "0"
       return
    }
   
    
    func playSound() {
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }

    func operationProcess(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Substract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputlabl.text = result
                
            }
            
            currentOperation = operation
        }else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}




