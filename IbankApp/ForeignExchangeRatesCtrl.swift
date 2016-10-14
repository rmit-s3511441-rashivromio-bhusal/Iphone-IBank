//
//  ForeignExchangeRatesCtrl.swift
//  IbankApp
//
//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForeignExchangeRatesCtrl: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    @IBOutlet weak var ratesTable: UITableView!
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var arrRates = [String:Double]() //Array of dictionary
        override func viewDidLoad() {
        super.viewDidLoad()
        
               //for side bar menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        getCurrenctData()
        
    }
    func loadTransactions(){

        ratesTable.dataSource = self;
        ratesTable.delegate = self;
    }
    
    func getCurrenctData(){
        Alamofire.request(.GET, "http://api.fixer.io/latest?base=AUD").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                for (key, object) in swiftyJsonVar["rates"] {
                    self.arrRates[key] = object.doubleValue
                }
                
                if self.arrRates.count > 0 {
                    self.ratesTable.reloadData()
                    
                    self.loadTransactions()
                }
            }
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //ratesTable.contentInset = UIEdgeInsetsZero;
       
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("rates")!
        cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "rates")
        print(Array(self.arrRates.values)[indexPath.row])
        cell.textLabel?.text = Array(self.arrRates.keys)[indexPath.row]
        cell.detailTextLabel?.text = String(Array(self.arrRates.values)[indexPath.row])
        return cell

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRates.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        self.performSegueWithIdentifier("convertCur", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "convertCur"){
            let destinationVC = segue.destinationViewController as! currencyConverter;
            destinationVC.curFrom = (ratesTable.cellForRowAtIndexPath(ratesTable.indexPathForSelectedRow!)?.textLabel?.text)!;
            destinationVC.curFromRate = (ratesTable.cellForRowAtIndexPath(ratesTable.indexPathForSelectedRow!)?.detailTextLabel?.text)!;
            destinationVC.currencyList = arrRates
        }
    }
  
    
      
}
