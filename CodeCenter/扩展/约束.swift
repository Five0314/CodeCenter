//
//  Constraint.swift
//  BusinessTime
//
//  Created by Five0314 on 16/3/15.
//  Copyright © 2016年 Five0314. All rights reserved.
//

import UIKit

public extension UIView{
    //MARK: 宽、高约束
    /**
     固定宽度、高度约束集
     
     - parameter specifiedWidth:  宽度
     - parameter specifiedHeight: 高度
     
     - returns: 约束集
     */
    func constraints(specifiedWidth:Float?, specifiedHeight:Float?) -> [NSLayoutConstraint]{
        var constraints:[NSLayoutConstraint] = []
        
        if specifiedWidth != nil{
            let constraint_Width = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(specifiedWidth!))
            
            constraints.append(constraint_Width)
        }
        
        if specifiedHeight != nil{
            let constraint_Height = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(specifiedHeight!))
            
            constraints.append(constraint_Height)
        }
        
        return constraints
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
    func constraints(secondeItem:UIView?, top:Float?, bottom:Float?, leading:Float?, trailing:Float?) -> [NSLayoutConstraint]{
        return self.constraints(secondeItem, top: top, bottom: bottom, leading: leading, trailing: trailing, relatedWidth: nil, relatedHeight: nil, centerX: nil, centerY: nil, specifiedWidth: nil, specifiedHeight: nil)
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
    func constraints(secondeItem:UIView?, relatedWidth:Float?, relatedHeight:Float?, centerX:Float?, centerY:Float?) -> [NSLayoutConstraint]{
        return self.constraints(secondeItem, top: nil, bottom: nil, leading: nil, trailing: nil, relatedWidth: relatedWidth, relatedHeight: relatedHeight, centerX: centerX, centerY: centerY, specifiedWidth: nil, specifiedHeight: nil)
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
    func constraints(secondeItem:UIView?, centerX:Float?, centerY:Float?, specifiedWidth:Float?, specifiedHeight:Float?) -> [NSLayoutConstraint]{
        let arr_Constraints = self.constraints(secondeItem, top: nil, bottom: nil, leading: nil, trailing: nil, relatedWidth: nil, relatedHeight: nil, centerX: centerX, centerY: centerY, specifiedWidth: specifiedWidth, specifiedHeight: specifiedHeight)
        
        return arr_Constraints
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
    func constraints(secondeItem:UIView?, top:Float?, bottom:Float?, leading:Float?, trailing:Float?, relatedWidth:Float?, relatedHeight:Float?, centerX:Float?, centerY:Float?) -> [NSLayoutConstraint]{
        let arr_Constraints = self.constraints(secondeItem, top: top, bottom: bottom, leading: leading, trailing: trailing, relatedWidth: relatedWidth, relatedHeight: relatedHeight, centerX: centerX, centerY: centerY, specifiedWidth: nil, specifiedHeight: nil)
        
        return arr_Constraints
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
    func constraints(secondeItem:UIView?, top:Float?, bottom:Float?, leading:Float?, trailing:Float?, relatedWidth:Float?, relatedHeight:Float?, centerX:Float?, centerY:Float?, specifiedWidth:Float?, specifiedHeight:Float?) -> [NSLayoutConstraint]{
        var constraints:[NSLayoutConstraint] = []
        
        if secondeItem != nil{
            if top != nil && secondeItem != nil{//
                let constraint_Top = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: secondeItem, attribute: .Top, multiplier: 1.0, constant: CGFloat(top!))
                
                constraints.append(constraint_Top)
            }
            
            if bottom != nil && secondeItem != nil{//
                let constraint_Bottom = NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: secondeItem, attribute: .Bottom, multiplier: 1.0, constant: CGFloat(bottom!))
                
                constraints.append(constraint_Bottom)
            }
            
            if leading != nil && secondeItem != nil{//
                let constraint_Leading = NSLayoutConstraint(item: self, attribute: .Leading, relatedBy: .Equal, toItem: secondeItem, attribute: .Leading, multiplier: 1.0, constant: CGFloat(leading!))
                
                constraints.append(constraint_Leading)
            }
            
            if trailing != nil && secondeItem != nil{//
                let constraint_Tralling = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: secondeItem, attribute: .Trailing, multiplier: 1.0, constant: CGFloat(trailing!))
                
                constraints.append(constraint_Tralling)
            }
            
            if relatedWidth != nil{//宽（secondeItem 为空，则是固定宽度）
                let constraint_Width = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: secondeItem, attribute: secondeItem == nil ? .NotAnAttribute : .Width, multiplier: 1.0, constant: CGFloat(relatedWidth!))
                
                constraints.append(constraint_Width)
            }
            
            if relatedHeight != nil{//高（secondeItem 为空，则是固定高度）
                let constraint_Height = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: secondeItem, attribute: secondeItem == nil ? .NotAnAttribute : .Height, multiplier: 1.0, constant: CGFloat(relatedHeight!))
                
                constraints.append(constraint_Height)
            }
            
            if centerX != nil && secondeItem != nil{//
                let constraint_CenterX = NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: secondeItem, attribute: .CenterX, multiplier: 1.0, constant: CGFloat(centerX!))
                
                constraints.append(constraint_CenterX)
            }
            
            if centerY != nil && secondeItem != nil{//
                let constraint_CenterY = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: secondeItem, attribute: .CenterY, multiplier: 1.0, constant: CGFloat(centerY!))
                
                constraints.append(constraint_CenterY)
            }
        }
        
        //固定宽高
        if specifiedWidth != nil{
            let constraint_Width = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(specifiedWidth!))
            
            constraints.append(constraint_Width)
        }
        
        if specifiedHeight != nil{
            let constraint_Height = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(specifiedHeight!))
            
            constraints.append(constraint_Height)
        }
        
        
        return constraints
    }
}
