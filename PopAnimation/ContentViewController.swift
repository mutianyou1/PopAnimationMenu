//
//  ContentViewController.swift
//  PopAnimation
//
//  Created by 潘元荣(外包) on 16/8/24.
//  Copyright © 2016年 潘元荣(外包). All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    private let imageView = UIImageView.init(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: "fengjing.jpg")
        self.view.addSubview(self.imageView)
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGrayColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        self.imageView.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer.init()
        gesture.numberOfTapsRequired = 1
        gesture.addTarget(self, action: "clickImageToDismiss")
        self.imageView.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.
    }
    func clickImageToDismiss(){
      self.navigationController?.dismissViewControllerAnimated(false, completion: { () -> Void in
        
      })
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
