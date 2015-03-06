

import UIKit
import Foundation

class LoginViewController: UIViewController,UITextFieldDelegate ,HttpProtocol{
    
    var FzList:NSArray?
    
    var eHttp:HttpController = HttpController()
    
    let txtUserName:UITextField = UITextField()
    let txtPassWord:UITextField = UITextField()
    @IBAction func btnLogin(sender: AnyObject) {
        let UserName = txtUserName.text
        let Pwd = txtPassWord.text
        if(UserName != ""&&Pwd != ""){
            eHttp.delegate = self
            //登陆
            var httpLogin = GetService+"which=getLogin&UserName=\(UserName)&PassWord=\(Pwd)"
            eHttp.onSearch(httpLogin)
           
        }else{
            let stoploadConfirm = UIAlertView(title: "警告", message: "用户名或密码不能为空", delegate: self, cancelButtonTitle: "好的")
            stoploadConfirm.show()
        }
       
    }
    //接收返回的数据
    func didReceiveResult(result: NSDictionary) {
        if(result.allKeys[0] as String == "FzList"){
            FzList = result["FzList"]! as? NSArray
        }else if(result.allKeys[0] as String == "customer"){
            if result["customer"] != nil{
                var items:NSMutableArray = NSMutableArray()
                loginInfo = result["customer"]! as? NSDictionary
                var MyStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                var oneController =  MyStoryBoard.instantiateViewControllerWithIdentifier("NaForCx") as UINavigationController
                var CxListView = CxListTableViewController()
                let Psz1 = FzList![0] as NSDictionary
                let PszId = (Psz1["Pszid"]?.intValue)!
                CxListView.PszId = Int(PszId)
                oneController.tabBarItem.title = "创新"
                oneController.tabBarItem.tag = 10010
                items.addObject(oneController)
                var twoController = MyStoryBoard.instantiateViewControllerWithIdentifier("NaForCy") as UINavigationController
                twoController.tabBarItem.title = "创业"
                twoController.tabBarItem.tag = 10086
                items.addObject(twoController)
                var navController = UITabBarController()
                navController.viewControllers = items
                var controller = mianController()
                self.presentViewController(controller, animated: true, completion: nil)
               
            }else{
                let stoploadConfirm = UIAlertView(title: "警告", message: "用户名或密码不正确", delegate: self, cancelButtonTitle: "好的")
                stoploadConfirm.show()
            }
            
        }else if(result.allKeys[0] as String == "error"){
            let stoploadConfirm = UIAlertView(title: "警告", message: "用户名或密码不正确", delegate: self, cancelButtonTitle: "好的")
            stoploadConfirm.show()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         eHttp.delegate = self
        //获取分组数据
        let FzUrl = GetService + "which=FzList"
        dispatch_async(dispatch_get_main_queue(), {self.eHttp.onSearch(FzUrl)})

        let BackGroundImage = UIImage(named: "LoginImageH4.jpg")!
        self.view.backgroundColor = UIColor(patternImage: BackGroundImage)
        //用户名
         txtUserName.frame = CGRectMake(386, 290, 252, 55)
        txtUserName.background = UIImage(named: "inputbox.png")
        txtUserName.delegate = self
        txtUserName.borderStyle = UITextBorderStyle.None
        let imageName = UIImageView(image: UIImage(named: "people2.png"))
        txtUserName.leftView = imageName
        txtUserName.leftViewMode = UITextFieldViewMode.Always
        self.view.addSubview(txtUserName)
        //密码
        txtPassWord.frame = CGRectMake(386, 364, 252, 55)
        txtPassWord.background = UIImage(named: "inputbox.png")
        txtPassWord.delegate = self
        txtPassWord.borderStyle = UITextBorderStyle.None
        txtPassWord.secureTextEntry = true
        let imagePwd = UIImageView(image: UIImage(named: "key2.png"))
        txtPassWord.leftView = imagePwd
        txtPassWord.leftViewMode = UITextFieldViewMode.Always
        self.view.addSubview(txtPassWord)
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

}
