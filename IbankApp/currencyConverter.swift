//
//  currencyConverter.swift
//  IbankApp
//
//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//
import UIKit

class currencyConverter: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {

    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var afterConvert: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratePicker: UIPickerView!
     var currencyList = [String:Double]() //Array of dictionary

    var curFrom: String = ""
    var curFromRate: String = ""
    override func viewDidLoad() {
        print(currencyList)
        super.viewDidLoad()
        titleLabel.text = "Convert from AUD";
        amount.text = "1";
        afterConvert.text = curFromRate
//        ratePicker.selectRow(1, inComponent: 0, animated: true)
        //ratePicker.selectedRowInComponent(1);
        ratePicker.dataSource = self;
        ratePicker.delegate = self;
    }
    
    @IBAction func amountChange(sender: UITextField) {
        let selectedValue: Double = Double(Array(self.currencyList.values)[ratePicker.selectedRowInComponent(0)])
        let enterValue = Double(amount.text!)
         afterConvert.text = String(enterValue! * selectedValue)

    }

        func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
            return 1
        }
    
        func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return Array(self.currencyList.keys).count;
        }
    
        func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return Array(self.currencyList.keys)[row]
        }
    
    
}
