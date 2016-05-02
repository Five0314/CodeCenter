//
//  自定义属性.swift
//  BusinessTime
//
//  Created by mac on 16/4/13.
//  Copyright © 2016年 kaifa24. All rights reserved.
//

import Foundation

extension NSObject{
    /**
     *  @author Five, 16-03-25 15:03:37
     *
     *  扩展属性Key
     */
    private struct AssociatedKeysForNSObject {
        static var loadProgress = "loadProgress"//进度
    }
    
    //MARK: - 进度标签
    class CNLoadProgressPanel{
        var cnlp: CNLoadProgress = .UnLoad
        
        init(lp: CNLoadProgress){
            self.cnlp = lp
        }
    }
    
    var loadProgress: CNLoadProgress{
        get{
            if let v = objc_getAssociatedObject(self, &AssociatedKeysForNSObject.loadProgress){
                return (v as! CNLoadProgressPanel).cnlp
            }
            else{
                return .UnLoad
            }
        }
        set{
            if let v = objc_getAssociatedObject(self, &AssociatedKeysForNSObject.loadProgress){
                (v as! CNLoadProgressPanel).cnlp = newValue
            }
            else{
                let v = CNLoadProgressPanel(lp: newValue);
                objc_setAssociatedObject(self, &AssociatedKeysForNSObject.loadProgress, v, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}