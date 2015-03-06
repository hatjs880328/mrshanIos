//
//  ListViewController.swift
//  SeeNow
//
//  Created by apple on 14/12/23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,HttpProtocol {
    //个人详细信息
    var perInfoView = UIView(frame: CGRectMake(1024, 65, 0, 703))
    let frame0 = CGRectMake(1024, 65, 0, 703)
    let frame1 = CGRectMake(264, 65, 760, 703)
    let frame2 = CGRectMake(264, 768, 760, 0)
    //个人信息的标签和背景图
    let btnClose = UIButton(frame: CGRectMake(715, 4, 29, 29))
    let lblName = UILabel(frame: CGRectMake(37, 3, 200, 27))
    //初评分组
    let lblCpfz = UILabel(frame: CGRectMake(37, 3, 200, 27))
    //定型意见
    let lblDxyj = UILabel(frame: CGRectMake(37, 3, 200, 27))
    //所属领域
    let lblSsly = UILabel(frame: CGRectMake(62, 75, 200, 27))
    //组内平均分
    let lblPjf = UILabel(frame: CGRectMake(62, 148, 200, 27))
    //意见说明
    let lblyj = UILabel(frame: CGRectMake(62, 222, 60, 27))
    
    let View1 = UIView(frame: CGRectMake(25, 37, 720, 33))
    let View3 = UIView(frame: CGRectMake(25, 110, 720, 33))
    let View5 = UIView(frame: CGRectMake(25, 183, 720, 33))
    
    let webView = UIWebView(frame: CGRectMake(0, 300, 760, 403))
    //接收数据
    var CyList:NSArray = NSArray()
    //评审组ID
    var PszId = 280
    //图片缓存
    var imageCache = Dictionary<String,UIImage>()
    
    var eHttp:HttpController = HttpController()
    
    
    @IBOutlet weak var btnList: UIButton!
    @IBOutlet weak var btnPic: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        //初始化页面上的控件属性
        initView()
        self.view.addSubview(perInfoView)
        let CyListUrl = GetService + "which=CyList&PszId=\(PszId)"
        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //初始化个人详细信息页面
        drawPerView()
        eHttp.delegate = self
        eHttp.onSearch(CyListUrl)
        
    }
    //接收返回的数据
    func didReceiveResult(result: NSDictionary) {
        if(result.allKeys[0] as NSString == "CyList"){
            println(result)
            if result["CyList"] != nil{
                self.CyList = result["CyList"] as NSArray
                self.mainTableView.reloadData()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return CyList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CyCell", forIndexPath: indexPath) as PerCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let rowData = CyList[indexPath.row] as NSDictionary
        cell.lblName.text = rowData["Xm_zw"] as NSString
        cell.DetailLabel.text = rowData["Qymc"] as NSString
        //照片路径
        if rowData["Fjlj"] == nil{
            cell.perImageView.image = UIImage(named: "grayicon.png")
        }else
        {
            let picRelative = rowData["Fjlj"] as NSString
            let image = imageCache[picRelative]
            if image != nil{
                cell.perImageView.image = image!
            }else{
                //个人照片地址
                let pic = FjUrl + picRelative
                let imgUrl = NSURL(string: pic)!
                let request:NSURLRequest = NSURLRequest(URL: imgUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                    let img = UIImage(data: data)
                    cell.perImageView.image = img!
                    self.imageCache[picRelative] = img
                })
            }
        }
        
        return cell
    }
    //初始化页面控件
    func initView(){
        btnPic.frame = CGRectMake(985, 30, 29, 29)
        btnList.frame = CGRectMake(946, 30, 29, 29)
        txtSearch.frame = CGRectMake(422, 30, 160, 25)
        txtSearch.leftView = UIImageView(image: UIImage(named: "seac.png"))
        txtSearch.leftViewMode = UITextFieldViewMode.Always
        txtSearch.background = UIImage(named: "seacrh.png")
        txtSearch.borderStyle = UITextBorderStyle.None
        topView.backgroundColor = UIColor(patternImage: UIImage(named: "topng.png")!)
        perInfoView.backgroundColor = UIColor.whiteColor()
    }
    //初始化个人信息页面控件
    func drawPerView(){
        perInfoView.layer.cornerRadius = 5
        perInfoView.layer.borderWidth = 2
        perInfoView.layer.borderColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 0.5).CGColor
        btnClose.backgroundColor = UIColor(patternImage: UIImage(named: "shut.png")!)
        btnClose.addTarget(self, action: "closePerInfoView:", forControlEvents: UIControlEvents.AllTouchEvents)
        perInfoView.addSubview(btnClose)
        View1.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        View3.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        View5.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        lblName.text = "sfdsfasdfdasf"
        View1.addSubview(lblName)
        perInfoView.addSubview(View1)
        
        lblCpfz.text = "sdfsdf"
        View3.addSubview(lblCpfz)
        perInfoView.addSubview(View3)
        
        lblDxyj.text = "ss"
        View5.addSubview(lblDxyj)
        perInfoView.addSubview(View5)
        
        lblSsly.text = "aabbcc"
        lblPjf.text = "aabbcc"
        lblyj.text = "aabbcc"
        perInfoView.addSubview(lblSsly)
        perInfoView.addSubview(lblPjf)
        perInfoView.addSubview(lblyj)
        
        perInfoView.addSubview(webView)
        
        
        
    }
    //个人信息数据加载
    func loadData(rowData:NSDictionary){
        let SbsUrl = HWZPUrl + "CySbs/CySbs.aspx?Sbbh=" + (rowData["Sbsid"] as NSString)
        let url = NSURL(string: SbsUrl)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        let Xm = rowData["Xm_zw"] as NSString
        lblName.text = "申报人选：\(Xm)"
        let Ssly = rowData["Ssly"] as NSString
        lblSsly.text = "所属领域：\(Ssly)"
        let Pszmc = rowData["Pszmc"] as NSString
        lblCpfz.text = "初评分组：\(Pszmc)"
        
    }
    
    func closePerInfoView(sender:UIButton)
    {
        UIView.animateWithDuration(0.3, animations: {()->Void in
            //self.perInfoView.frame = self.frame2
            self.perInfoView.frame = self.frame0
        })
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let rowData = CyList[indexPath.row] as NSDictionary
        loadData(rowData)
        UIView.animateWithDuration(0.3, animations: {()->Void in
            self.perInfoView.frame = self.frame1
        })
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
}
