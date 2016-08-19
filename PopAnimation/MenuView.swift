//
//  MenuView.swift
//  PopAnimation
//
//  Created by 潘元荣(外包) on 16/8/18.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

import UIKit


let kButtonItemHeigth = UIScreen.mainScreen().bounds.size.width/(CGFloat.init(3))
let titlesArray = ["照相","头条","拍摄","签到","点评","更多"]

public enum PopViewType{case PopViewFromCenter,PopViewFromOriginalFrame,PopViewFromRandomFrame}
public enum PopViewBackGorudType{case PopViewBackGroundLight, PopViewBackGroundDark}
///set PopViewAnimationType
///- parameter type enmu has 3 kinds of types
///backgroundType:dark and light
public func setPopViewWithPopType(type:PopViewType, backgroundType:PopViewBackGorudType){
    MenuView.MenuViewInstance.popType = type
    switch backgroundType{
    case .PopViewBackGroundLight:
        //default type
        break
    case .PopViewBackGroundDark:
        MenuView.MenuViewInstance.effectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style:.Dark))
        break
    }
}
public protocol MenuViewDelegate:NSObjectProtocol{
   func clickMenuViewOnItemWithIndex(index :Int)->Void
   func clickMenuViewOnBottomButton()->Void
}

class MenuView: UIView {
   //单例模式
   static let MenuViewInstance = MenuView(frame: UIScreen.mainScreen().bounds)
   
   private let bottomButton = UIButton.init(type:UIButtonType.Custom)
   private lazy var itemsArray = [MenuButtonItem]()
   private var popType = PopViewType.PopViewFromCenter
   private lazy var effectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style:.ExtraLight))
    //delegate  属性
    weak var delegate : MenuViewDelegate?
    
   //MARK:init
   private  override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
  override  func didMoveToSuperview() {
        //模糊效果
        //    let effectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style:.ExtraLight))
    super.didMoveToSuperview()
    if(self.itemsArray.count > 0){return}
        self.effectView.frame = self.bounds
        self.addSubview(self.effectView)
        
        
        let logo = UIImageView.init(frame: CGRectMake(self.bounds.size.width - 200, 80, 200, 30))
        logo.contentMode = UIViewContentMode.Center
        logo.image = UIImage(named: "img-2")
        self.addSubview(logo)
        
        self.bottomButton.frame = CGRectMake(self.bounds.size.width * 0.5 - 20, self.bounds.size.height - 40, 40, 40)
        self.bottomButton.setBackgroundImage(UIImage.init(named: "tabbar_compose_background"), forState: .Normal)
        self.addSubview(bottomButton)
        self.bottomButton.addTarget(self, action: "clickButtonDropItmes", forControlEvents: UIControlEvents.TouchUpInside)
    }
    //MARK:setButonItems
    func setButtonItems( itemNames :[String]?){
        self.bottomButton.transform = CGAffineTransformIdentity
        if self.itemsArray.count > 0 {return}
        for(var i = 0;i<itemNames?.count ;i++){
            
            var rect = CGRectMake(CGFloat.init(i % 3) * kButtonItemHeigth, self.bounds.size.height, kButtonItemHeigth, kButtonItemHeigth)
            switch self.popType {
            case .PopViewFromCenter:
                rect.origin.x = self.bounds.size.width*0.5 - kButtonItemHeigth*0.5
                break
            case .PopViewFromOriginalFrame:
                break
            case .PopViewFromRandomFrame:
                let width = Int32.init(self.bounds.size.width)
                srand(UInt32(time(nil)))
                rect.origin.x = CGFloat.init(rand() % width)
                break
            
            
            }
            let item = MenuButtonItem.init(frame: rect)
            item.tag = i
            item.imageName = itemNames![i]
            item.titleString = titlesArray[i]
            self.addSubview(item)
            item.setItemClickBlock({ (tag) -> Void in
                UIView.animateWithDuration(NSTimeInterval.init(0.1)) { () -> Void in
                    self.bottomButton.transform = CGAffineTransformIdentity
                }
                self.delegate!.clickMenuViewOnItemWithIndex(tag)
            })
            self.itemsArray.append(item)
        }
        
    }
    //TODO: --Animation
    func buttonsStartAnimating(){
        self.setBottomButtonTransformAnimation(CGAffineTransformMakeRotation(CGFloat.init(M_PI_4 + M_PI * 4)))
        for(var i = 0;i < self.itemsArray.count;i++){
           let item = self.itemsArray[i]
           var rect = item.frame
            if(rect.origin.y < self.bounds.size.height){
               rect.origin.y = self.bounds.size.height
               item.frame = rect
            }
                rect.origin.y = self.bounds.size.height * 0.3 + CGFloat.init(i/3) * kButtonItemHeigth
                rect.origin.x = CGFloat.init(i % 3) * kButtonItemHeigth
                item.transform = CGAffineTransformMakeScale( 0.1, 2.8)
                UIView.animateWithDuration(Double.init(i%3)*0.5 + 0.3, delay: 0.0, usingSpringWithDamping: 10.0 , initialSpringVelocity: 5.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    item.transform = CGAffineTransformIdentity
                    item.frame = rect
                    }, completion: { (bool:Bool) -> Void in
                        
                })
        }
        
    }
    func clickButtonDropItmes(){
        var delay = self.itemsArray.count
        var delaySeconds =  Double.init(delay/6)
        self.setBottomButtonTransformAnimation(CGAffineTransformIdentity)
        for(var i = self.itemsArray.count - 1;i >= 0;i--){
            let item = self.itemsArray[i]
            var rect = item.frame
            rect.origin.y = self.bounds.size.height+CGFloat.init(i%3)*30
            switch self.popType {
            case .PopViewFromCenter:
                rect.origin.x = self.bounds.size.width*0.5 - kButtonItemHeigth*0.5
                break
            case .PopViewFromOriginalFrame:
                break
            case .PopViewFromRandomFrame:
                let width = Int32.init(self.bounds.size.width)
                srand(UInt32(time(nil)))
                rect.origin.x = CGFloat.init(rand() % width)
                break
            }
            delay = self.itemsArray.count - i - 1
            delaySeconds =  Double.init(delay)*0.06
           
            // 5/6   2/6 1/6 0
            UIView.animateWithDuration(1.5, delay:delaySeconds, usingSpringWithDamping:10.0 , initialSpringVelocity:2, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                item.frame = rect
                }, completion: { (isbool:Bool) -> Void in
                    if(item.tag == 0 && isbool==true){
                     self.delegate?.clickMenuViewOnBottomButton()
                    }
            })
        }

    }
    //MARK:bottomButtonTransformMake
   private func setBottomButtonTransformAnimation(transform_:CGAffineTransform){
        UIView.animateWithDuration(NSTimeInterval.init(1.0)) { () -> Void in
            self.bottomButton.transform = transform_
        }
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
