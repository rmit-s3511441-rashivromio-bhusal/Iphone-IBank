//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//

import Foundation

class SavingAccount{
    var accountHolder:String?
    var accountNo:String?
    var balance:Double?
    var transactions : [Transaction]?
    
    init(accountHolder: String?, accountNo: String?, balance: Double?, transactions: [Transaction]?) {
        self.accountHolder = accountHolder
        self.accountNo = accountNo
        self.balance = balance
        self.transactions = transactions
    }
    
    func addTransaction(tran: Transaction){
        self.transactions?.append(tran);
    }

    
}
