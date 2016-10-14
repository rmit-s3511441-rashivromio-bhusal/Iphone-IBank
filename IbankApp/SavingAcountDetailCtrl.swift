//
//  acountDetailCtrl.swift
//  IbankApp
//
//  Created by Naveen Bajaj on 8/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//

import UIKit

class SavingAcountDetailCtrl: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var sAccount: SavingAccount!
    
    @IBOutlet weak var sAccNo: UILabel!
    @IBOutlet weak var sAccName: UILabel!
    
    @IBOutlet weak var sAccbal: UILabel!
    var databasePath = NSString()
    
    @IBOutlet weak var transactionTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let docsDir = "/Users/ROMIO"
        print(docsDir)
        databasePath = (docsDir as NSString).stringByAppendingPathComponent(
            "iBankApp.db")
        
        sAccNo.text = sAccount.accountNo
        sAccName.text = sAccount.accountHolder
        sAccbal.text = "$" + String(format:"%.2f", (sAccount.balance)!)
        loadTransactions();
    }
    func loadTransactions(){
        transactionTable.dataSource = self;
        transactionTable.delegate = self;
        
    }
    
    func updateAccount(){
        print("here373426736")
        let iBankAppDB = FMDatabase(path: databasePath as String)
        var trans : [Transaction] = []
        if iBankAppDB.open() {
            let transactionSQL = "select * from transaction_details where account_no = '\(sAccount.accountNo!)'";
            let transactionResults:FMResultSet? = iBankAppDB.executeQuery(transactionSQL,
                withArgumentsInArray: nil)
            while(transactionResults?.next() == true){
                print(transactionResults?.resultDictionary())
                trans.append(Transaction(description: transactionResults?.stringForColumn("description")!, date: transactionResults?.stringForColumn("date")!, amount: transactionResults?.doubleForColumn("amount")))
            }
            
            
            let saccountSQL = "select * from saccount where account_no = '\(sAccount.accountNo!)'";
            print("saccountSQL---"+saccountSQL);
            let saccountResults:FMResultSet? = iBankAppDB.executeQuery(saccountSQL,
                withArgumentsInArray: nil)
            
            if saccountResults?.next() == true {
                
                sAccount = SavingAccount(accountHolder: saccountResults?.stringForColumn("account_holder")!, accountNo: saccountResults?.stringForColumn("account_no")!, balance: saccountResults?.doubleForColumn("balance"),transactions: trans);
                
                iBankAppDB.close()
            }

            sAccNo.text = sAccount.accountNo
            sAccName.text = sAccount.accountHolder
            sAccbal.text = "$" + String(format:"%.2f", (sAccount.balance)!)
            
            dispatch_async(dispatch_get_main_queue()){
                self.transactionTable.reloadData()
            }

        }
       

    }
    
    @IBAction func transferFunds(sender: UIButton) {
        
        self.performSegueWithIdentifier("fundsTransfer", sender: sender)
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sAccount.transactions?.count)!;
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
   
   
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "myCell";
        var cell = transactionTable.dequeueReusableCellWithIdentifier(identifier);
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier);
        }
        let c1 = cell?.textLabel
        c1!.text = sAccount.transactions![indexPath.row].description! + "\t" + String(format:"%.2f", (sAccount.transactions![indexPath.row].amount)!);
        cell?.detailTextLabel?.text = sAccount.transactions![indexPath.row].date;
        transactionTable.contentInset = UIEdgeInsetsZero;
        return cell!;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "fundsTransfer"){
            let destinationVC = segue.destinationViewController as! FundTransferCtrl;
            print("sAccount.accountNo-----"+sAccount.accountNo!)
            destinationVC.user_acc_no = sAccount.accountNo;
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        updateAccount()
    }
    

}
