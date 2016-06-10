//
//  CNNavigationController.swift
//  CodeCenter
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 Five. All rights reserved.
//

import UIKit

class CNNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        print("NVG =============== shouldAutorotate")
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        print("NVG =============== supportedInterfaceOrientations")
        if let vc = self.visibleViewController{
            if vc.respondsToSelector(#selector(UIViewController.supportedInterfaceOrientations)){
                return vc.supportedInterfaceOrientations()
            }
        }
        return .Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .LandscapeRight
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

extension UINavigationController{
    override public func shouldAutorotate() -> Bool {
        print("extensionNVG =============== shouldAutorotate")
        return true
    }
    
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        print("extensionNVG =============== supportedInterfaceOrientations")
        if let vc = self.visibleViewController{
            if vc.respondsToSelector(#selector(UIViewController.supportedInterfaceOrientations)){
                return vc.supportedInterfaceOrientations()
            }
        }
        return .Portrait
    }
    
    override public func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        print("extensionNVG =============== preferredInterfaceOrientationForPresentation")
        if let vc = self.visibleViewController{
            if vc.respondsToSelector(#selector(UIViewController.preferredInterfaceOrientationForPresentation)){
                return vc.preferredInterfaceOrientationForPresentation()
            }
        }
        return .LandscapeRight
    }
}
