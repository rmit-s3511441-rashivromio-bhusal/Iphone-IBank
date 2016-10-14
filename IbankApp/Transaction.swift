//
//  Transaction.swift
//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//

import Foundation

class Transaction{
    var date:String?
    var amount:Double?
    var description:String?
    
    init(description: String?, date: String?, amount: Double?) {
        self.description = description
        self.date = date
        self.amount = amount
    }
    
    
    
}
