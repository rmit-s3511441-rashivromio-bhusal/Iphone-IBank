//
//  todayBank.swift
//  IbankApp
//
//  Created by Naveen Bajaj on 20/05/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//


import Foundation

class todayBank {
    
    var banks = [
        "there is a special offer in the bank if you visit today",
        "if you apply for the credit card today then you will get $50 as a bonus",
        "we are giving $100 for the 1st 10 people who apply for the saving account",
        "new interest rate available for the home loan today"
    ]
    func randomBank() ->String{
        return banks[ Int(arc4random_uniform(UInt32(banks.count)))]
    }
    

}
