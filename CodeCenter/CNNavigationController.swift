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
    
    override var shouldAutorotate : Bool {
//        print("NVG =============== shouldAutorotate")
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
//        print("NVG =============== supportedInterfaceOrientations")
        if let vc = self.visibleViewController{
            if vc.responds(to: #selector(getter: UIViewController.supportedInterfaceOrientations)){
                return vc.supportedInterfaceOrientations
            }
        }
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return .landscapeRight
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
    override open var shouldAutorotate : Bool {
//        print("extensionNVG =============== shouldAutorotate")
        return true
    }
    
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
//        print("extensionNVG =============== supportedInterfaceOrientations")
        if let vc = self.visibleViewController{
            if vc.responds(to: #selector(getter: UIViewController.supportedInterfaceOrientations)){
                return vc.supportedInterfaceOrientations
            }
        }
        return .portrait
    }
    
    override open var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
//        print("extensionNVG =============== preferredInterfaceOrientationForPresentation")
        if let vc = self.visibleViewController{
            if vc.responds(to: #selector(getter: UIViewController.preferredInterfaceOrientationForPresentation)){
                return vc.preferredInterfaceOrientationForPresentation
            }
        }
        return .landscapeRight
    }
}
