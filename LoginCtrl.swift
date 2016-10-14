//
//  LoginCtrl.swift
//  IbankApp
//
//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//

import UIKit

class LoginCtrl: UIViewController {
     var currentUser: User!
    var saving: SavingAccount!
    var current: CurrentAccount!
   
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var welcomeMsg: UILabel!

    @IBOutlet weak var sAccountNo: UILabel!
    @IBOutlet weak var sBalance: UILabel!
    
    @IBOutlet weak var cAccountNo: UILabel!
    
    @IBOutlet weak var cardExp: UILabel!
    @IBOutlet weak var cardNo: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var cCreditLimit: UILabel!
    @IBOutlet weak var cBalance: UILabel!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTitle.title = "Welcome " + currentUser.username!;
        self.navigationTitle.backBarButtonItem?.title = "back"
        //welcomeMsg.text = "Welcome " + currentUser.username!;
        
        sAccountNo.text = "Account No: " + (currentUser.sAccount?.accountNo)!
        sBalance.text = "Balance: $" + String(format:"%.2f", (currentUser.sAccount?.balance)!)
        
        cAccountNo.text = "Account No: " + (currentUser.cAccount?.accountNo)!
        cBalance.text = "Balance: $" + String(format:"%.2f", (currentUser.cAccount?.balance)!)
        cCreditLimit.text = "Credit Limit: $" + String(format:"%.2f", (currentUser.cAccount?.creditLimit)!)
        
        cardType.text = "Card Type: " + (currentUser.card?.type)!
        cardNo.text =  (currentUser.card?.number)!
        cardExp.text = "Expiry Date: " + (currentUser.card?.expiryDate)!
        
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   //    @IBAction func sAccountDetails(sender: AnyObject) {
//        print(currentUser.sAccount?.accountHolder)
//         saving = currentUser.sAccount
//         self.performSegueWithIdentifier("sAccDetails", sender: sender)
//       
//       
//        
//    }
//
//    @IBAction func cAccDetails(sender: AnyObject) {
//        current = currentUser.cAccount
//        self.performSegueWithIdentifier("cAccDetails", sender: sender)
//        
//
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       print(segue.identifier)
        if(segue.identifier == "sAccDetails"){
        let savingDestinationVC = segue.destinationViewController as! SavingAcountDetailCtrl;
        savingDestinationVC.sAccount = currentUser.sAccount;
        }
        else if(segue.identifier == "cAccDetails"){
        let currentDestinationVC = segue.destinationViewController as! CurrentAccountDetailsCtrl;
        currentDestinationVC.cAccount = currentUser.cAccount;
        }
    }

}
