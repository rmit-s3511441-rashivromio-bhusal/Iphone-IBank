
//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//
import Foundation

class User{
    var username:String?
    var password:String?
    var sAccount:SavingAccount?
    var cAccount:CurrentAccount?
    var card:Card?
    
    init(username: String?, password: String?, sAccount: SavingAccount?, card: Card?) {
        self.username = username
        self.password = password
        self.sAccount = sAccount
        self.card = card
    }
    init(username: String?, password: String?, sAccount: SavingAccount?, cAccount:CurrentAccount?, card: Card?) {
        self.username = username
        self.password = password
        self.sAccount = sAccount
        self.cAccount = cAccount
        self.card = card
    }
}
