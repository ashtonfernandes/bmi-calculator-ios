//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Ashton Fernandes on 2018-03-12.
//  Copyright © 2018 Ashton Fernandes. All rights reserved.
//

import UIKit

var Bmi: Double = 0
var totalWeight: Double = 0
var totalHeight: Double = 0

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        yourBmiText.isHidden = true
        yourBmiValue.isHidden = true
        youAreText.isHidden = true
        youAreValue.isHidden = true
        
        //Listen for keyboard show/hide events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)),name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    // Stop listening for keyboartd show/hide events
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var weightValue: UITextField!
    @IBOutlet weak var heightInFeetValue: UITextField!
    @IBOutlet weak var heightInInchesValue: UITextField!
    @IBOutlet weak var yourBmiText: UILabel!
    @IBOutlet weak var yourBmiValue: UITextField!
    @IBOutlet weak var youAreText: UILabel!
    @IBOutlet weak var youAreValue: UITextField!
    
    @IBAction func calculateBmi(_ sender: UIButton) {
        
        totalWeight = Double(weightValue.text!)!
            
        totalHeight = Double(heightInFeetValue.text!)! * 12 + Double(heightInInchesValue.text!)!
            
        Bmi =  (totalWeight / totalHeight / totalHeight) * 703
        
        yourBmiValue.text = String(Bmi)
        
        if (Bmi > 25) {
            youAreValue.text = "You are Overwight"
        } else if (Bmi > 18.5 ) {
            youAreValue.text = "You are good!"
        } else {
            youAreValue.text = "You are Underwight"
        }

        sender.isHidden = true
        yourBmiText.isHidden = false
        yourBmiValue.isHidden = false
        youAreText.isHidden = false
        youAreValue.isHidden = false
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        print("Keyboard will change \(notification.name.rawValue)")
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
                view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
    }
}

