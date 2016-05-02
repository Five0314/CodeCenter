//
//  约束OC.swift
//  ShowView
//
//  Created by line on 16/4/24.
//  Copyright © 2016年 Five. All rights reserved.
//

import Foundation

public extension UIView{
    
    //MARK: 宽、高约束
    /**
     固定宽度、高度约束集
     
     - parameter specifiedWidth:  宽度
     - parameter specifiedHeight: 高度
     
     - returns: 约束集
     */
    public func constraintsOC(specifiedWidth:NSNumber?, specifiedHeight:NSNumber?) -> NSMutableArray{
        let mArray = self.constraints(specifiedWidth?.floatValue, specifiedHeight: specifiedHeight?.floatValue)
        
        return NSMutableArray(array: mArray)
    }
    
    //MARK: 上、下、左、右约束
    /**
     上、下、左、右约束集
     
     - parameter secondeItem: 关联View
     - parameter top:         上
     - parameter bottom:      下
     - parameter leading:     左
     - parameter trailing:    右
     
     - returns: 约束集
     */
    func constraintsOC(secondeItem:UIView?, top:NSNumber?, bottom:NSNumber?, leading:NSNumber?, trailing:NSNumber?) -> NSMutableArray{
        let mArray = self.constraints(secondeItem, top: top?.floatValue, bottom: bottom?.floatValue, leading: leading?.floatValue, trailing: trailing?.floatValue)
        
        return NSMutableArray(array: mArray)
    }
    
    //MARK: 宽、高、水平居中、垂直居中约束
    /**
     宽、高、水平居中、垂直居中约束集
     
     - parameter secondeItem: 关联View
     - parameter relatedWidth:       关联宽度
     - parameter relatedHeight:      关联高度
     - parameter centerX:     水平居中
     - parameter centerY:     垂直居中
     
     - returns: 约束集
     */
    func constraintsOC(secondeItem:UIView?, relatedWidth:NSNumber?, relatedHeight:NSNumber?, centerX:NSNumber?, centerY:NSNumber?) -> NSMutableArray{
        let mArray = self.constraints(secondeItem, relatedWidth: relatedWidth?.floatValue, relatedHeight: relatedHeight?.floatValue, centerX: centerX?.floatValue, centerY: centerY?.floatValue)
        
        return NSMutableArray(array: mArray)
    }
    
    //MARK: 水平居中、垂直居中、固定宽度、固定宽度约束
    /**
     水平居中、垂直居中、固定宽度、固定宽度约束集
     
     - parameter secondeItem: 关联View
     - parameter centerX:     水平居中
     - parameter centerY:     垂直居中
     - parameter specifiedWidth:  固定宽度
     - parameter specifiedHeight: 固定高度
     
     - returns: 约束集
     */
    func constraintsOC(secondeItem:UIView?, centerX:NSNumber?, centerY:NSNumber?, specifiedWidth:NSNumber?, specifiedHeight:NSNumber?) -> NSMutableArray{
        let mArray = self.constraints(secondeItem, centerX: centerX?.floatValue, centerY: centerY?.floatValue, specifiedWidth: specifiedWidth?.floatValue, specifiedHeight: specifiedHeight?.floatValue)
        
        return NSMutableArray(array: mArray)
    }
    
    //MARK: 上、下、左、右、宽、高、水平居中、垂直居中约束
    /**
     上、下、左、右、宽、高、水平居中、垂直居中约束集
     
     - parameter secondeItem: 关联View
     - parameter top:         上
     - parameter bottom:      下
     - parameter leading:     左
     - parameter trailing:    右
     - parameter relatedWidth:       关联宽度
     - parameter relatedHeight:      关联高度
     - parameter centerX:     水平居中
     - parameter centerY:     垂直居中
     
     - returns: 约束集
     */
    func constraintsOC(secondeItem:UIView?, top:NSNumber?, bottom:NSNumber?, leading:NSNumber?, trailing:NSNumber?, relatedWidth:NSNumber?, relatedHeight:NSNumber?, centerX:NSNumber?, centerY:NSNumber?) -> NSMutableArray{
        
        let mArray = self.constraints(secondeItem, top: top?.floatValue, bottom: bottom?.floatValue,
                                      leading: leading?.floatValue, trailing: trailing?.floatValue,
                                      relatedWidth: relatedWidth?.floatValue, relatedHeight: relatedHeight?.floatValue,
                                      centerX: centerX?.floatValue, centerY: centerY?.floatValue,
                                      specifiedWidth: nil, specifiedHeight: nil)
        
        return NSMutableArray(array: mArray)
    }
    
    //MARK: 上、下、左、右、宽、高、水平居中、垂直居中、固定宽度、固定高度约束
    /**
     上、下、左、右、宽、高、水平居中、垂直居中约束集
     
     - parameter secondeItem: 关联View
     - parameter top:         上
     - parameter bottom:      下
     - parameter leading:     左
     - parameter trailing:    右
     - parameter relatedWidth:       关联宽度
     - parameter relatedHeight:      关联高度
     - parameter centerX:     水平居中
     - parameter centerY:     垂直居中
     - parameter specifiedWidth:  固定宽度
     - parameter specifiedHeight: 固定高度
     
     - returns: 约束集
     */
    func constraintsOC(secondeItem:UIView?, top:NSNumber?, bottom:NSNumber?, leading:NSNumber?, trailing:NSNumber?, relatedWidth:NSNumber?, relatedHeight:NSNumber?, centerX:NSNumber?, centerY:NSNumber?, specifiedWidth:NSNumber?, specifiedHeight:NSNumber?) -> NSMutableArray{
        
        let mArray = self.constraints(secondeItem, top: top?.floatValue, bottom: bottom?.floatValue,
                                      leading: leading?.floatValue, trailing: trailing?.floatValue,
                                      relatedWidth: relatedWidth?.floatValue, relatedHeight: relatedHeight?.floatValue,
                                      centerX: centerX?.floatValue, centerY: centerY?.floatValue,
                                      specifiedWidth: specifiedWidth?.floatValue, specifiedHeight: specifiedHeight?.floatValue)
        
        return NSMutableArray(array: mArray)
    }
}
