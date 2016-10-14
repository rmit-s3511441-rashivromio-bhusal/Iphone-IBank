//
//  CurrentAccount.swift
//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//

import Foundation

class CurrentAccount{
    var accountHolder:String?
    var accountNo:String?
    var creditLimit:Double?
    var balance:Double?
    var transactions : [Transaction]?
    
    init(accountHolder: String?, accountNo: String?, creditLimit:Double?, balance: Double?, transactions : [Transaction]?) {
        self.accountHolder = accountHolder
        self.accountNo = accountNo
        self.creditLimit = creditLimit
        self.balance = balance
        self.transactions = transactions
    }
    
    func transfer() {
    }
    
}

