//
//  宏定义.swift
//  Test
//
//  Created by Five0314 on 16/3/22.
//  Copyright © 2016年 Five0314. All rights reserved.
//

import Foundation

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

 /// 分隔线颜色
let SeparatorColor = RGB(243, green: 243, blue: 243)



