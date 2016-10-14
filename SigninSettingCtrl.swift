

import UIKit

class SigninSettingCtrl: UIViewController {

    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var uname: UITextField!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var databasePath = NSString()
    
    var currentUser: User!
//    var users : [User] = []
  
    override func viewDidAppear(animated: Bool) {
//            passwd.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uname.becomeFirstResponder();
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        if(currentUser != nil){
            
        }

         let docsDir = "/Users/ROMIO"
        
        databasePath = (docsDir as NSString).stringByAppendingPathComponent(
            "iBankApp.db")
        
//        let sAcc = SavingAccount(accountHolder: "Naveen Bajaj", accountNo: "4356-329871", balance: 1000,transactions: trans)
//        let cAcc = CurrentAccount(accountHolder: "Friends Business", accountNo: "4356-537651", creditLimit: 10000, balance: 1000,transactions: trans)
//        let card1 = Card(type: "Debit card", number: "4352-7465-8361-2689", expiryDate: "15-7-2020")
//        users = [User(username: "naveen", password: "bajaj", sAccount: sAcc, cAccount: cAcc, card: card1)]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func checkCredential(sender: UIButton) {
        //Database connectivity to check the credential of user
        let iBankAppDB = FMDatabase(path: databasePath as String)
        
        if iBankAppDB.open() {
           let userSQL = "select * from user where username = '\(uname.text!)' and password = '\(passwd.text!)'";

            let userResults:FMResultSet? = iBankAppDB.executeQuery(userSQL,
                withArgumentsInArray: nil)

            if userResults?.next() == true {
                let sAccNo = userResults?.stringForColumn("saccount_no")
                var trans : [Transaction] = [];
                
                //transaction details
                let transactionSQL = "select * from transaction_details where account_no = '\(sAccNo!)'";
                let transactionResults:FMResultSet? = iBankAppDB.executeQuery(transactionSQL,
                                    withArgumentsInArray: nil)
                while(transactionResults?.next() == true){
                    print(transactionResults?.resultDictionary())
                    trans.append(Transaction(description: transactionResults?.stringForColumn("description")!, date: transactionResults?.stringForColumn("date")!, amount: transactionResults?.doubleForColumn("amount")))
                }
                
                //saving account details
                
                let saccountSQL = "select * from saccount where account_no = '\(sAccNo!)'";

                let saccountResults:FMResultSet? = iBankAppDB.executeQuery(saccountSQL,
                    withArgumentsInArray: nil)
                var sAcc: SavingAccount!
                if saccountResults?.next() == true {
                    
                 sAcc = SavingAccount(accountHolder: saccountResults?.stringForColumn("account_holder")!, accountNo: saccountResults?.stringForColumn("account_no")!, balance: saccountResults?.doubleForColumn("balance"),transactions: trans)
                }
                //current account details
                let cAccNo = userResults?.stringForColumn("caccount_no")
                let caccountSQL = "select * from caccount where account_no = '\(cAccNo!)'";
                let caccountResults:FMResultSet? = iBankAppDB.executeQuery(caccountSQL,
                    withArgumentsInArray: nil)
                
                var cAcc: CurrentAccount!
                 if caccountResults?.next() == true {
                 cAcc = CurrentAccount(accountHolder: caccountResults?.stringForColumn("account_holder")!, accountNo: caccountResults?.stringForColumn("account_no")!, creditLimit: caccountResults?.doubleForColumn("credit_limit"), balance: caccountResults?.doubleForColumn("balance"),transactions: trans)
                }

                
                //card details
                let cno = userResults?.stringForColumn("card_no")
                let cardSQL = "select * from card where card_no = '\(cno!)'";
                let cardResults:FMResultSet? = iBankAppDB.executeQuery(cardSQL,
                    withArgumentsInArray: nil)
                var card1: Card!
                 if cardResults?.next() == true {
                  card1 = Card(type: cardResults?.stringForColumn("type")!, number: cardResults?.stringForColumn("card_no")!, expiryDate: cardResults?.stringForColumn("expiry_date")!)
                }

                currentUser = User(username: "naveen", password: "bajaj", sAccount: sAcc, cAccount: cAcc, card: card1);

                self.performSegueWithIdentifier("loginCheck", sender: sender)
            } else {
                let alert = UIAlertController(title: "Invalid Credentials",
                    message: "Invalid username or password.",
                    preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                presentViewController(alert, animated: true, completion: nil)
            }
            iBankAppDB.close()
        } else {
            print("Error: \(iBankAppDB.lastErrorMessage())")
        }
        
   
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destinationViewController as! LoginCtrl;

        destinationVC.currentUser = currentUser;
    }
    
  
}
