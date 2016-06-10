//
//  UIColor扩展.swift
//  CodeCenter
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 Five. All rights reserved.
//

import UIKit

// MARK: - 颜色

/**
 自定义颜色（透明度为1）
 
 - parameter red:   红
 - parameter green: 绿
 - parameter blue:  蓝
 
 - returns: UIColor
 */
func RGB(red: Float, green: Float, blue: Float) -> UIColor{
    return RGB(red, green: green, blue: blue, alpha: 1.0)
}

/**
 自定义颜色
 
 - parameter red:   红
 - parameter green: 绿
 - parameter blue:  蓝
 - parameter alpha: 透明度
 
 - returns: UIColor
 */
func RGB(red: Float, green: Float, blue: Float, alpha: Float) -> UIColor{
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
}

extension UIColor{
     /// 分隔线
    var CNSeparatorColor:UIColor{
        get{
            return RGB(243, green: 243, blue: 243)
        }
    }
}