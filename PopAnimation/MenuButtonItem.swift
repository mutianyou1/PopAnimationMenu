//
//  MenuButtonItem.swift
//  PopAnimation
//
//  Created by 潘元荣(外包) on 16/8/18.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

import UIKit
private let KItemButtonHeight :CGFloat = 80.0
class MenuButtonItem: UIControl {
    
    private let button = UIButton.init(type: UIButtonType.Custom)
    private let title = UILabel.init()
    private var clickBlock =  ({(tag:Int)->Void in})
    var imageName:String{
        get{
            return "abc"
        }
        set{
          button.setBackgroundImage(UIImage.init(named: newValue), forState: .Normal)
        }
    }
    var titleString:String{
        get{
            return "abc"
        }
        set{
           title.text = newValue
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        button.frame.size = CGSizeMake(KItemButtonHeight, KItemButtonHeight)
        button.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5)
        button.addTarget(self, action: "clickOnButton", forControlEvents: UIControlEvents.TouchUpInside)
        title.frame = CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)
        title.textColor = UIColor.lightGrayColor()
        title.textAlignment = NSTextAlignment.Center
        self.addSubview(button)
        self.addSubview(title)
    }
    ///给item设置block无返回值
    ///- parameter block 闭包参数为tag
    func setItemClickBlock(block:(tag:Int) ->Void){
      self.clickBlock = block
    }
    func clickOnButton(){
       self.clickBlock(self.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
