//
//  CNMutableAttributedString.swift
//  BusinessTime
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 kaifa24. All rights reserved.
//

import UIKit

class CNMutableAttributedString: NSObject {

}

extension NSMutableAttributedString{
    //MARK: - 高亮字符串
    /**
     高亮
     
     - parameter text:           需要高亮的字符串
     - parameter regular:        正则
     - parameter highlightColor: 高亮颜色
     
     - returns: NSMutableAttributedString
     */
    static func stringWithRegular(_ text: String?, regular: String?, highlightColor: UIColor?) -> NSMutableAttributedString?{
        if text == nil{
            return nil
        }
        else{
            return NSMutableAttributedString.stringWithRegular(text, regular: regular, highlightColor: highlightColor, range: NSMakeRange(0, text!.characters.count))
        }
    }
    
    /**
     高亮
     
     - parameter text:           需要高亮的字符串
     - parameter regular:        正则
     - parameter highlightColor: 高亮颜色
     - parameter range:          可高亮的字符串的范围
     
     - returns: NSMutableAttributedString
     */
    static func stringWithRegular(_ text: String?, regular: String?, highlightColor: UIColor?, range: NSRange) -> NSMutableAttributedString?{
        if text == nil || regular == nil || highlightColor == nil{
            return nil
        }
        
        do{
            let regex = try NSRegularExpression(pattern: regular!, options: .caseInsensitive)
            let regularResult = regex.matches(in: text!, options: .reportCompletion, range: range)
            
            let attributedString = NSMutableAttributedString(string: text!)
            for checkingResult in regularResult {
                attributedString.addAttribute(NSForegroundColorAttributeName, value: highlightColor!, range: checkingResult.range)
            }
            
            return attributedString
        }
        catch{
            return nil
        }
    }
    
    /**
     高亮 between ~ and 之间的字符
     
     - parameter text:           需要高亮的字符串
     - parameter between:        高亮起始字符
     - parameter and:            高亮结束字符
     - parameter highlightColor: 高亮颜色
     
     - returns: NSMutableAttributedString
     */
    static func stringWithRegular(_ text: String?, between: String?, and: String?, highlightColor: UIColor?) -> NSMutableAttributedString?{
        if text == nil || between == nil || and == nil || highlightColor == nil{
            return nil
        }
        
        do{
//             "“((?!”.*“).)+”";
            let regularString = between! + "((?!" + between! + ".*" + and! + ").)+" + and!
            let regex = try NSRegularExpression(pattern: regularString, options: .caseInsensitive)
            let regularResult = regex.matches(in: text!, options: .reportCompletion, range: NSMakeRange(0, text!.characters.count))
            
            let attributedString = NSMutableAttributedString(string: text!)
            for checkingResult in regularResult {
                attributedString.addAttribute(NSForegroundColorAttributeName, value: highlightColor!, range: checkingResult.range)
            }
            
            return attributedString
        }
        catch{
            return nil
        }
    }
}
