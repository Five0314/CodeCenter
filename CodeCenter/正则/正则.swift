//
//  正则.swift
//  CodeCenter
//
//  Created by line on 16/5/8.
//  Copyright © 2016年 Five. All rights reserved.
//

import UIKit

extension NSString{
    ///两个字符之间，封闭边界，举个栗子（“”：匹配中文双引号之间的内容）
    static func cnRegular(between between: String, and: String) -> String{
        //"“((?!”.*“).)+”"
        
        return between + "((?!" + between + ".*" + and + ").)+" + and
    }
    
    ///匹配制定的字符
    static func cnRegular(specifiedString astring: String) -> String{
        //"“((?!”.*“).)+”"
        
        return astring + "+"
    }
}
