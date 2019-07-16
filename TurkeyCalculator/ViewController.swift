//
//  ViewController.swift
//  TurkeyCalculator
//
//  Created by Casualty on 7/15/19.
//  Copyright © 2019 Casualty. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var turkeyWeightLabel: UILabel!
    
    @IBOutlet weak var turkeyWeightTextField: UITextField!
    
    @IBOutlet weak var appTitle: UILabel!
    
    @IBOutlet weak var cookTimeLabel: UILabel!
    
    @IBOutlet weak var cookTimeTextField: UITextField!

    @IBOutlet weak var metricButton: UIButton!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var stepperButton: UIStepper!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var darkModeLabel: UILabel!
    
    @IBOutlet weak var secretButton: UIButton!
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        metricButton.layer.cornerRadius = 4
        stepperButton.wraps = true
        stepperButton.autorepeat = true
        stepperButton.maximumValue = 30
        stepperButton.minimumValue = 0
        switchButton.isOn = false
        webView = WKWebView()
        webView.navigationDelegate = self
        stepperButton.stepValue = 1
        turkeyWeightTextField.text = "0"
    }
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
        guard let turkeyWeightString = turkeyWeightTextField.text else { return }
        guard let turkeyWeight = Double(turkeyWeightString) else {
            print("Invalid number")
            return
            
        }
        
        var durationInMinutes: Double
        
        if metricButton.isSelected {
            durationInMinutes = cookTimeInKilograms(turkeyWeight)
            turkeyWeightLabel.text = "Turkey Weight (kg):"
        } else {
            durationInMinutes = cookTimeInPounds(turkeyWeight)
            turkeyWeightLabel.text = "Turkey Weight (lb):"
        }
        cookTimeTextField.text = "\(durationInMinutes) minutes"

    
    }
    
    func cookTimeInPounds(_ weight: Double) -> Double {
        let duration = weight * 15
        return duration
        
    }
    
    func cookTimeInKilograms(_ weight: Double) -> Double {
        var durationInMinutes: Double
        
        if weight >= 4 {
            durationInMinutes = 20 * weight + 90
        } else {
            durationInMinutes = 20 * weight + 70
        }
        return durationInMinutes
    }
    
    @IBAction func metricButtonPressed(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        button.isSelected.toggle()
        if button.isSelected {
            turkeyWeightLabel.text = "Turkey Weight (kg):"
            calculateButtonPressed((Any).self)
        } else {
            turkeyWeightLabel.text = "Turkey Weight (lb):"
            calculateButtonPressed((Any).self)
        }
        
    }
    
    @IBAction func stepperButtonPressed(_ sender: UIStepper!) {
        
        turkeyWeightTextField.text = Int(stepperButton.value).description
        calculateButtonPressed((Any).self)
    }
    
    @IBAction func switchButtonPressed(_ sender: Any) {
        if switchButton.isOn {
            self.view.backgroundColor = .black
            turkeyWeightLabel.textColor = .white
            cookTimeLabel.textColor = .white
            appTitle.textColor = .white
            appTitle.backgroundColor = .black
            darkModeLabel.textColor = .white
        } else {
            self.view.backgroundColor = .white
            turkeyWeightLabel.textColor = .black
            cookTimeLabel.textColor = .black
            appTitle.textColor = .black
            appTitle.backgroundColor = .white
            darkModeLabel.textColor = .black

        }
        
        
    }
    
    @IBAction func secretButtonPressed(_ sender: Any) {
        view = webView
        let url = URL(string: "https://www.thomasdye.me")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}

