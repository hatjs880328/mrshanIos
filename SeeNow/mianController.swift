//
//  mianController.swift
//  SeeNow
//  swz....
//  Created by apple on 14/12/5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

import UIKit
var mmm = 0

class mianController: UIViewController,UITableViewDataSource,UITableViewDelegate,HttpProtocol,backvalue {
    
    let tableview = UITableView(frame: CGRect(x:0,y:0,width:900,height:500), style: UITableViewStyle.Plain)
    let hidtableview = UITableView(frame: CGRect(x:1023,y:0,width:1024,height:500), style: UITableViewStyle.Plain)
    let hidview = UIView(frame: CGRect(x:1023,y:0,width:1024,height:500))
    let dxview = UIView(frame: CGRect(x:1023,y:0,width:1024,height:500))
    let webview = UIWebView(frame: CGRect(x:1023,y:0,width:500,height:500))
    var button = UIButton(frame: CGRect(x:0,y:600,width:100,height:20))
    var label = UILabel(frame: CGRect(x:500,y:0,width:300,height:60))
    var ehttp:HttpController = HttpController()
    var leftdata:NSArray = []
    var sbsid:String?
    var xm:String?
    var Pszid:String?
    var back = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thread2()
        println(back)
        mainscrean()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tag = 1
        hidtableview.delegate = self
        hidtableview.dataSource = self
        hidtableview.alpha = CGFloat(0.0);
        hidtableview.tag = 2
        var url = GetService+"which=CxList&PszId=279"
        ehttp.delegate  = self
        ehttp.onSearch(url)
        
    }
    //开启异步执行方法（线程打印no字符串）一直到死
    func thread2()->Void{
        var time:UInt32 = 0
        if(mmm==0){
            time = 3
        }else{
            time = 9
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //这里写需要大量时间的代码
            for var i = 0; i < 500; i--
            {
                sleep(time);
                println("no")
                if(i == -3){
                    println("检测到已经打分完毕，所以循环结束。如果从别的界面跳转回本页面此线程将重新执行。")
                    break
                }
            }
            //返回主线程跳转才可以成功（提示也只有在主线程中才会成功）
            dispatch_async(dispatch_get_main_queue(), {
                println("这里返回主线程，写需要主线程执行的代码")
                var al = UIAlertView(title: "自动跳转", message: "监听线程检测到打分过程已经结束，自动跳转到投票界面", delegate: self, cancelButtonTitle: "好")
                al.show()
                let controller = votecontroller()
                self.govote()
            })
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mainscrean()->Void
    {
        
        
        //topview
        self.view.backgroundColor = UIColor.whiteColor()
        var topview = UIView(frame:CGRect(x:0,y:0,width:1024,height:68))
        topview.backgroundColor = UIColor.grayColor()
        topview.alpha = CGFloat(0.3)
            //加标头
            self.label.text = "会议评审系统"
            self.label.textColor = UIColor.redColor()
            self.label.backgroundColor = UIColor.grayColor()
            label.alpha = CGFloat(1.0)
            topview.addSubview(self.label)
        
        self.view.addSubview(topview)
        //botview
        var botview = UIView(frame:CGRect(x:0,y:700,width:1024,height:68))
        botview.backgroundColor = UIColor.grayColor()
        botview.alpha = CGFloat(0.3)
        self.view.addSubview(botview)
        //midview
        var midview = UIView(frame:CGRect(x:0,y:69,width:1024,height:632))
        midview.backgroundColor = UIColor.whiteColor()
            //add  tableviewcontroller
            midview.addSubview(tableview)
            hidview.alpha = CGFloat(0.0)
            //add tar
        var swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Right
        self.hidview.addGestureRecognizer(swipeLeftGesture)
        hidview.backgroundColor = UIColor.grayColor()
        hidview.alpha = CGFloat(0.4)
            midview.addSubview(hidview)
        
        self.view.addSubview(midview)
        midview.addSubview(webview)
        webview.alpha = CGFloat(0.0)
        //定性界面
        dxview.alpha = CGFloat(0.0)
        dxview.backgroundColor = UIColor.redColor()
        midview.addSubview(dxview)
        var swipeLeftGesture1 = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture1:")
        swipeLeftGesture1.direction = UISwipeGestureRecognizerDirection.Right
        self.dxview.addGestureRecognizer(swipeLeftGesture1)

        midview.addSubview(dxview)
        webviewshow()
        //hidden button
        button.backgroundColor = UIColor.redColor()
        button.titleLabel?.text = "...."
        button.alpha = CGFloat(0.0)
        button.addTarget(self, action: "clckme:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    //隐藏view的控件的添加
    func hidviewCompAdd()->Void{
        println(xm)
        var label = UILabel(frame: CGRect(x:2,y:2,width:100,height:40))
        label.text = "姓名:"
        label.backgroundColor = UIColor.redColor()
        hidview.addSubview(label)
        var label1 = UILabel(frame: CGRect(x:110,y:2,width:200,height:40))
        label1.text = "\(deloptionText(xm!))"
        label1.backgroundColor = UIColor.redColor()
        hidview.addSubview(label1)
        var label12 = UILabel(frame: CGRect(x:2,y:45,width:100,height:40))
        label12.text = "评审组id"
        label12.backgroundColor = UIColor.redColor()
        hidview.addSubview(label12)
        var label123 = UILabel(frame: CGRect(x:110,y:45,width:200,height:40))
        label123.text = "\(deloptionText(Pszid!))"
        label123.backgroundColor = UIColor.redColor()
        hidview.addSubview(label123)
    }
    //webview的控制
    func webviewshow()->Void{
        println("urlrequest2")
        var str = "http://www.sina.com"
        var nsurl3 = NSURL(string: str)
        var request = NSURLRequest(URL:nsurl3!)
        self.webview.loadRequest(request)
        println("urlrequest")
    }
    //the table's rows' count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(tableView.tag == 1){
            return leftdata.count
        }
        if(tableView.tag == 2){
            return 5
        }
        else{
            return 7
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if(tableView.tag == 1)
        {
            var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell3") as UITableViewCell
            var label = UILabel(frame: CGRect(x:200,y:0,width:100,height:30))
            label.tag = 11
            cell.contentView.addSubview(label)
            var Label = cell.contentView.viewWithTag(11)
            //label.text = "sss"
            var button = UIButton(frame: CGRect(x:300,y:0,width:100,height:30))
            button.backgroundColor = UIColor.redColor()
            cell.contentView.addSubview(button)
            button.tag = 12
            button.addTarget(self, action: "shanwenzheng:", forControlEvents: UIControlEvents.TouchUpInside)
            var Button = cell.contentView.viewWithTag(12)
            //button
            let button2 = UIButton(frame: CGRect(x:410,y:0,width:50,height:30))
            button2.backgroundColor = UIColor.yellowColor()
            button2.tag = 33
            cell.contentView.addSubview(button2)
            var but = cell.contentView.viewWithTag(33)
            
            
            var rowdata = leftdata[indexPath.row] as NSDictionary
            println(rowdata)
            var m = rowdata["Xm_zw"] as String
            cell.textLabel?.text = m
            cell.detailTextLabel?.text = rowdata["Zw_zw"] as String?
            
            cell.imageView?.image = UIImage(named: "Flush2.png");
            var str = FjUrl+(rowdata["Fjlj"] as String)
            var url = NSURL(fileURLWithPath: str)
            if rowdata["Fjlj"] == nil{
                //cell.imageView?.image = UIImage(named: "11.png")
            }else
            {
                let picRelative = rowdata["Fjlj"] as NSString
                if 2==3{
                }else{
                    //个人照片地址
                    let pic = FjUrl + picRelative
                    let imgUrl = NSURL(string: pic)!
                    let request:NSURLRequest = NSURLRequest(URL: imgUrl)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                        let img = UIImage(data: data)
                        if(data != nil){
                        cell.imageView?.image = img
                        }
                    })
                }
            }
            return cell
        }
        else {
            var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil) as UITableViewCell
            println(sbsid)
            cell.textLabel?.text = xm
            cell.detailTextLabel?.text = Pszid;
            cell.imageView?.image = nil
            
            //在这里添加手势
            var swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
            swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Right
            self.view.addGestureRecognizer(swipeLeftGesture)
            return cell
        }
    }
    //数据加载时，列表的效果
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if(tableview.tag == 1){
            cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        }
    }
    
    func shanwenzheng(sender:UIButton){
        println("shan")
    }
    
    //table 点击时触发的事件
    func  tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var jd:NSDictionary?
        var id2 = "sdf"
        if(tableView.tag == 1){
            var url = GetService+"which=Gcjd&Pszid=279&Pcid=2014&Zjid=467261bf-ab6b-4ab7-99f5-00f51f92b555"
            let NSUrl:NSURL = NSURL(string: url)!
            let request:NSURLRequest = NSURLRequest(URL: NSUrl)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                 jd = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
                id2 = jd!["customer"] as String
                //测试用跳转到投票页面
                //id2 = "2"
                if(id2 == "0" ){
                    //打分界面跳出
                    self.clickme(self.button)
                    var rowdata = self.leftdata[indexPath.row] as NSDictionary
                    self.sbsid = rowdata["Sbsid"] as String?
                    self.xm = rowdata["Xm_zw"] as String?
                    self.Pszid = rowdata["Pszid"] as String?
                    self.hidviewCompAdd()
                    var frame = CGRect(x:502,y:0,width:400,height:500)
                    var frame3 = CGRect(x:0,y:0,width:400,height:500)
                    UITableViewCell.animateWithDuration(1, animations: {
                        self.hidview.alpha = CGFloat(1.0)
                        self.hidview.frame = frame
                        //webview同时加载出来
                        self.webview.alpha = CGFloat(1)
                        self.webview.frame = frame3
                        }, completion: nil)
                }else if(id2 == "1"){
                    //定性意见页面的跳出
                    var msg = UIAlertView(title: "定性结果页面", message: "仅仅是为了测试定型页面", delegate: self, cancelButtonTitle: "结束")
                    msg.show()
                }else if(id2 == "2"){
                    //投票的页面的推出
                    println(".....")
                    let controller = votecontroller()
                    self.govote()
                    
                }
            })
            
            
        }else{
            println("can't press");
        }
    }
    
    
    func clickme(sender:UIButton){
                //animate....
                var frame = CGRect(x:900,y:0,width:400,height:500)
                UIButton.animateWithDuration(2, animations: {
                    self.hidview.alpha = CGFloat(0.0)
                    self.hidview.frame = frame
                    self.webview.alpha = CGFloat(0.0)
                    self.webview.frame = frame
                    }
                    , completion: {(finishde:Bool)->Void in
                        if(finishde){
                        }
                })
    }
    
    //互动回去
    func handleSwipeGesture(sender:UISwipeGestureRecognizer){
        clickme(button)
    }
    
    func handleSwipeGesture1(sender:UISwipeGestureRecognizer){
         var frame = CGRect(x:900,y:0,width:400,height:500)
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.dxview.alpha = CGFloat(0.0)
            self.dxview.frame = frame
        })
    }
    
    
    func didReceiveResult(result:NSDictionary){
        println("")
        var ui = UIAlertView(title: "msg", message: "start info....", delegate: self, cancelButtonTitle: "cancle")
        //ui.show()
        //println(result)
        if(result.allKeys[0] as String == "CxList"){
            if (result["CxList"] != nil){
                self.leftdata = result["CxList"] as NSArray
                dispatch_async(dispatch_get_main_queue(), {self.tableview.reloadData()})
            }
        }
    }
    
    func deloptionText(name:String)->String{
        return (name as NSString).substringFromIndex(0)
    }
    
    func govote()->Void{
        var con = votecontroller()
        con.backv = self
        self.presentViewController(con, animated: true) { () -> Void in
            println("goforit...")
        }
        
    }
    func backvalue1(stringms:Int){
        back = stringms
        println(back)
        
    }
}
