//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        fruitPicker.dataSource = self
        fruitPicker.delegate = self
        
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        
        for c in 0...2 {
            let row = Int(arc4random_uniform(UInt32(fruitsArray.count-1)))
            fruitPicker.selectRow(row, inComponent: c, animated: true)
            print("row:\(row) comp:\(c)")
        }
        
        if fruitPicker.selectedRow(inComponent: 0) == fruitPicker.selectedRow(inComponent: 1) && fruitPicker.selectedRow(inComponent: 1) == fruitPicker.selectedRow(inComponent: 2) {
            
            blink(msg: "WINNER!")
        } else {
            blink(msg: "TRY AGAIN")
        }
        
    }
    
    func blink(msg:String) {
        //for _ in 1...3 {
            self.resultLabel.text = msg
        
            self.resultLabel.alpha = 1.0
            UIView.animate(withDuration: 1.5, delay:0.5,
                    options:[.repeat , .autoreverse],
                animations:{ self.resultLabel.alpha = 0.0 },
                completion:nil)
                //sleep(3)  //does not work for blinking
            //delay
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7), execute: {
                self.resultLabel.alpha = 1.0
                self.resultLabel.layer.removeAllAnimations()

            })      //does not work for blinking
            //self.resultLabel.text = ""
            print("blinking result")
        //}
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print("exiting numberOfComponents")
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruitsArray.count * 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
             return fruitsArray[row % (fruitsArray.count-1)]
     }
    
}

// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.white.cgColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



