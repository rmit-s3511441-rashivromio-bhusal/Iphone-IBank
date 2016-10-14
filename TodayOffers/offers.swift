//
//  offers.swift
//  IbankApp
//
//  Created by Naveen Bajaj on 20/05/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//

import Foundation

class offers {
    
    var messages = ["platinum credit cards offers. No annual fees.","Car loan at minimum interest"]
    
    func randomMessages() ->String {
        return messages[ Int(arc4random_uniform(UInt32(messages.count)))]
    }
}
