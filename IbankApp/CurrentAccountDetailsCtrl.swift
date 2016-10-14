//
//  CurrentAccountDetails.swift
//  IbankApp
//
//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//
import UIKit

class CurrentAccountDetailsCtrl: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var cAccount: CurrentAccount!
    
    @IBOutlet weak var cCreditLimit: UILabel!
    @IBOutlet weak var cBalance: UILabel!
    @IBOutlet weak var cAccountHName: UILabel!
    @IBOutlet weak var cAccountNo: UILabel!
    
    @IBOutlet weak var transactionTable: UITableView!
          override func viewDidLoad() {
        super.viewDidLoad()
        cAccountNo.text = cAccount.accountNo
        cAccountHName.text = cAccount.accountHolder
        cBalance.text = "$" + String(format:"%.2f", (cAccount.balance)!)
        cCreditLimit.text = "$" + String(format:"%.2f", (cAccount.creditLimit)!)
        loadTransactions();
    }
    func loadTransactions(){
        transactionTable.dataSource = self;
        transactionTable.delegate = self;
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //transactionTable.contentInset = UIEdgeInsetsZero;
        let identifier: String = "myCell";
        var cell = transactionTable.dequeueReusableCellWithIdentifier(identifier);
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: identifier);
        }
        let c1 = cell?.textLabel
        c1!.text = cAccount.transactions![indexPath.row].description! + "\t" + String(format:"%.2f", (cAccount.transactions![indexPath.row].amount)!);
        cell?.detailTextLabel?.text = cAccount.transactions![indexPath.row].date;
        transactionTable.contentInset = UIEdgeInsetsZero;
        return cell!;
    }

}
