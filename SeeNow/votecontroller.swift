//
//  votecontroller.swift
//  SeeNow
//
//  Created by apple on 14/12/11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

import UIKit
protocol backvalue:NSObjectProtocol{
    func backvalue1(stringms:Int)
}
class votecontroller: UIViewController {
    var aniview = UIView(frame: CGRectMake(20, 10, 100, 100))
    var midview = UIView(frame: CGRect(x:0,y:50,width:1024,height:600))
    var backv:backvalue?
    override func viewDidLoad() {
        super.viewDidLoad()
        mainscreen()
        self.aniview.backgroundColor = UIColor.blackColor()
        aniview.layer.cornerRadius = 50
        //self.view.addSubview(aniview)
        UIView.animateWithDuration(12, delay: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.aniview.transform = CGAffineTransformMakeTranslation(50, 0)
            self.aniview.backgroundColor = UIColor.redColor()
            }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //主界面页面控制方法
    func mainscreen()->Void{
        self.view.backgroundColor = UIColor.whiteColor()
        let but = UIButton(frame: CGRect(x:0,y:0,width:100,height:50))
        let but2 = UIButton(frame: CGRect(x:110,y:0,width:100,height:50))
        but.backgroundColor = UIColor.whiteColor()
        but.setTitle("返回", forState: UIControlState.Normal)
        but.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        but.addTarget(self, action: "goback:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(but)
        but2.backgroundColor = UIColor.yellowColor()
        but2.setTitle("前面的按钮是返回按钮", forState: UIControlState.Normal)
        //self.view.addSubview(but2)
        
        midview.backgroundColor = UIColor.clearColor()
        self.view.addSubview(midview)
        printvote(midview)
        println("...1")
        mmm = 2
        mmm3 = 2
    }
    //在midview中画投票的东西
    func printvote(uiview:UIView)->Void{
        //外部循环控制行
        for (var i = 0;i<7;i++ ){
            //内部循环控制每行的内容
            for(var j = 0 ;j<4;j++){
                let label = UILabel(frame: CGRect(x:i*100+i*10,y:j*100+j*10,width:100,height:100))
                label.backgroundColor = UIColor.yellowColor()
                label.text = "\(i)，\(j)"
                label.textColor = UIColor.redColor()
                midview.addSubview(label)
            }
        }
    }
    
    func goback(sender:UIButton){
        self.presentViewController(scrollView(), animated: true, completion: nil)
        backv?.backvalue1(3)
    }
    
    //animated
    func viewani()->Void{
        self.aniview.backgroundColor = UIColor.yellowColor()
        aniview.layer.cornerRadius = 50
        self.view.addSubview(aniview)
        UIView.animateWithDuration(0.9, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.aniview.transform = CGAffineTransformMakeTranslation(20, 250)
            self.aniview.backgroundColor = UIColor.blackColor()
        }, completion: nil)
        println("...")
    }

}
