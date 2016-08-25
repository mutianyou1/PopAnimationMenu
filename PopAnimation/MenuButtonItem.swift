//
//  MenuButtonItem.swift
//  PopAnimation
//
//  Created by 潘元荣(外包) on 16/8/18.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

import UIKit
private let KItemButtonHeight :CGFloat = 80.0
private let KHeightScale : CGFloat = UIScreen.mainScreen().bounds.height/667.0
class MenuButtonItem: UIControl {
    
    private let button = UIButton.init(type: UIButtonType.Custom)
    private let title = UILabel.init()
    private var clickBlock =  ({(tag:Int)->Void in})
    private var image = UIImage.init()
    var imageName:String{
        get{
            return "abc"
        }
        set{
          self.image = UIImage.init(named: newValue)!
          button.setBackgroundImage(self.image, forState: .Normal)
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
        title.frame = CGRectMake(0, self.bounds.size.height - 20 * KHeightScale, self.bounds.size.width, 20*KHeightScale)
        title.font = UIFont.systemFontOfSize(18.0*KHeightScale)
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
    func getButtonImageColor() -> UIColor{
        let pixeData = CGDataProviderCopyData(CGImageGetDataProvider(self.image.CGImage))
        let data :UnsafePointer<UInt8> = CFDataGetBytePtr(pixeData)
        let pixeInfo : Int = ((Int(self.bounds.size.width) * Int(100)) + Int(100)) * 4
        return UIColor.init(red: CGFloat.init(data[pixeInfo])/255.0, green: CGFloat.init(data[pixeInfo+1])/255.0, blue: CGFloat.init(data[pixeInfo+2])/255.0, alpha: CGFloat.init(data[pixeInfo+3])/255.0)
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

