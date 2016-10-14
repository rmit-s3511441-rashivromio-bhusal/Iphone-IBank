//
//  FundTransferCtrl.swift
//  IbankApp
//
//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//

import UIKit

class FundTransferCtrl: UIViewController {
    var user_acc_no: String!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var accNo: UITextField!
    var databasePath = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let docsDir = "/Users/ROMIO"
        print(docsDir)
        databasePath = (docsDir as NSString).stringByAppendingPathComponent(
            "iBankApp.db")
    }
   
    @IBAction func transferFunds(sender: UIButton) {
        if(accNo.text == nil || accNo.text == ""){
            
                let alert = UIAlertController(title: "Error",
                    message: "Invalid Account Number",
                    preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                
                presentViewController(alert, animated: true, completion: nil)
                
            }
            else if(amount.text == nil || amount.text == ""){
                let alert = UIAlertController(title: "Error",
                    message: "Invalid Amount",
                    preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                
                presentViewController(alert, animated: true, completion: nil)
                
            }
            else{
                let iBankAppDB = FMDatabase(path: databasePath as String)
                var flag:Bool = false
                if iBankAppDB.open() {
                    let userToSQL = "update saccount set balance = balance + '\(amount.text!)' where account_no = '\(accNo.text!)'";
                    let transactionQuery1 = "insert into transaction_details values ('\(accNo.text!)','20-06-2016','\(amount.text!)','\(desc.text!)')";
                    let result1 = iBankAppDB.executeUpdate(transactionQuery1,
                        withArgumentsInArray: nil)
                    
                    let userFromSQL = "update saccount set balance = balance - '\(amount.text!)' where account_no = '\(user_acc_no!)'";
                    let amt:Double = 0 - Double(amount.text!)!
                    let transactionQuery2 = "insert into transaction_details values ('\(user_acc_no!)','20-06-2016','\(amt)','\(desc.text!)')";
                    let result2 = iBankAppDB.executeUpdate(transactionQuery2,
                        withArgumentsInArray: nil)
                    if (!result1 || !result2) {
                        flag = true
                    }
                    if !iBankAppDB.executeStatements(userFromSQL) {
                        print("Error: \(iBankAppDB.lastErrorMessage())")
                        flag = true
                    }
                    if !iBankAppDB.executeStatements(userToSQL) {
                        print("Error: \(iBankAppDB.lastErrorMessage())")
                        flag = true
                    }
                    if(!flag){
                        let alert = UIAlertController(title: "Success",
                            message: "Transfer Amount $" + amount.text!,
                            preferredStyle: .Alert)
                        let action = UIAlertAction(title: "Ok", style: .Default, handler: {
                            (_)in
                            self.performSegueWithIdentifier("unwindTransfer", sender: self)
                            })
                        alert.addAction(action)
                        
                        presentViewController(alert, animated: true, completion: nil)
                    }
                    else{
                        
                        let alert = UIAlertController(title: "Success",
                            message: "Do not Transfer",
                            preferredStyle: .Alert)
                        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                        alert.addAction(action)
                        
                        presentViewController(alert, animated: true, completion: nil)
                        //rollback.initialize(true)
                    }
                    iBankAppDB.close()
                }
                
            }
            
        
    }
//    @IBAction func updateAccount(sender: UIButton) {
//         self.performSegueWithIdentifier("userhome", sender: sender)
//    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       var trans : [Transaction] = []
        
        //transaction details
        let destinationVC = segue.destinationViewController as! SavingAcountDetailCtrl;
        var sAcc: SavingAccount!
        let iBankAppDB = FMDatabase(path: databasePath as String)
 if iBankAppDB.open() {
    let transactionSQL = "select * from transaction_details where account_no = '\(user_acc_no!)'";
    let transactionResults:FMResultSet? = iBankAppDB.executeQuery(transactionSQL,
        withArgumentsInArray: nil)
    while(transactionResults?.next() == true){
        print(transactionResults?.resultDictionary())
        trans.append(Transaction(description: transactionResults?.stringForColumn("description")!, date: transactionResults?.stringForColumn("date")!, amount: transactionResults?.doubleForColumn("amount")))
    }

    
        let saccountSQL = "select * from saccount where account_no = '\(user_acc_no!)'";
        print("saccountSQL---"+saccountSQL);
        let saccountResults:FMResultSet? = iBankAppDB.executeQuery(saccountSQL,
            withArgumentsInArray: nil)
    
        if saccountResults?.next() == true {
            
            sAcc = SavingAccount(accountHolder: saccountResults?.stringForColumn("account_holder")!, accountNo: saccountResults?.stringForColumn("account_no")!, balance: saccountResults?.doubleForColumn("balance"),transactions: trans);
            
            iBankAppDB.close()
        }
        }
        destinationVC.sAccount = sAcc;
    }
}
