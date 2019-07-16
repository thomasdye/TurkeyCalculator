//
//  ViewController.swift
//  TurkeyCalculator
//
//  Created by Casualty on 7/15/19.
//  Copyright © 2019 Casualty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var turkeyWeightLabel: UILabel!
    
    @IBOutlet weak var turkeyWeightTextField: UITextField!
    
    @IBOutlet weak var cookTimeTextField: UITextField!

    @IBOutlet weak var metricButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
    }
    
}

