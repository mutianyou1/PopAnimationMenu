//
//  ViewController.swift
//  PopAnimation
//
//  Created by 潘元荣(外包) on 16/8/18.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

import UIKit

class ViewController: UIViewController,MenuViewDelegate {
    
    let backgroundImageView = UIImageView.init(frame: UIScreen.mainScreen().bounds)
    let button = UIButton.init(type:UIButtonType.Custom)
    lazy var buttonTitlesArray = ["照相","头条","拍摄","签到","点评","更多"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImageView.image = UIImage(named: "IMG_3050.PNG")
        self.view.addSubview(backgroundImageView)
        self.button.frame = CGRectMake(self.view.bounds.size.width*0.5 - 20, self.view.bounds.size.height - 40, 40, 40)
        self.button.backgroundColor = UIColor.clearColor()
        self.button.addTarget(self, action:"clickOpenMenu", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.button)
        setPopViewWithPopType(PopViewType.PopViewFromOriginalFrame, backgroundType: PopViewBackGorudType.PopViewBackGroundLight,transitionType: PopViewTransitionType.TransitionWithZoomAndBackgroundColor)

        
        
        
    }
    func clickOpenMenu(){
        
         self.view.addSubview(MenuView.MenuViewInstance)
         MenuView.MenuViewInstance.delegate = self
     MenuView.MenuViewInstance.setButtonItems(["camera","idea","lbs","more","photo","review"])
         MenuView.MenuViewInstance.buttonsStartAnimating()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension MenuViewDelegate{
    func clickMenuViewOnItemWithIndex(index: Int) {
        MenuView.MenuViewInstance.removeFromSuperview()
         let title = ViewController().buttonTitlesArray[index]
         let navi =  ContentViewController()
         navi.title = title
         print(title)
         UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(UINavigationController.init(rootViewController: navi), animated: false, completion: { () -> Void in
            
         })
        
    }
    func clickMenuViewOnBottomButton(){
         MenuView.MenuViewInstance.removeFromSuperview()
    }
}
