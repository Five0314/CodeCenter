//
//  弹出隐藏视图OC.swift
//  BusinessTime
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 kaifa24. All rights reserved.
//

import Foundation


/// showInView.options
struct ViewShowAndHideOptionsOC{
    //MARK: 进入方向
    /// 进入方向
    var showStyle: CNShowOrHideStyleOC = .Right
    
    //MARK: 隐藏方向
    /// 隐藏方向
    var hideStyle: CNShowOrHideStyleOC = .None
    //    var asd: MaskType_0314
    //MARK: 约束
    /// 显示自己的父容器
    var superUV: UIView?
    
    //MARK: 约束
    /// self.top ~ superview.top
    var top: NSLayoutConstraint?
    
    /// self.bottom ~ superview.bottom
    var bottom: NSLayoutConstraint?
    
    /// self.leading ~ superview.leading
    var leading: NSLayoutConstraint?
    
    /// self.tralling ~ superview.tralling
    var tralling: NSLayoutConstraint?
    
    /// self.centerX ~ superview.centerX
    var centerX: NSLayoutConstraint?
    
    /// self.centerY ~ superview.centerY
    var centerY: NSLayoutConstraint?
    
    /// self.width ~ superview.width
    var relativeWidth: NSLayoutConstraint?
    
    /// self.heigth ~ superview.heigth
    var relativeHeight: NSLayoutConstraint?
    
    /// 固定宽度
    var specifiedWidth: NSLayoutConstraint?
    
    /// 固定高度
    var specifiedHeight: NSLayoutConstraint?
    
    //MARK: 遮罩层类型
    /// 遮罩层类型
    var maskStyle: CNMaskStyleOC = [CNMaskStyleOC.Add, CNMaskStyleOC.Show, CNMaskStyleOC.ClickEnable];
    
    init(superUV: UIView?, showDirection: CNShowOrHideStyleOC, hideDirection: CNShowOrHideStyleOC, maskStyle: CNMaskStyleOC, cs : [NSLayoutConstraint]){
        self.superUV = superUV
        
        self.showStyle = showDirection
        
        self.hideStyle = hideDirection
        
        self.maskStyle = maskStyle
        
        for lc in cs {
            if lc.firstAttribute == .Top{
                self.top = lc
            }
            else if lc.firstAttribute == .Bottom{
                self.bottom = lc
            }
            else if lc.firstAttribute == .Leading{
                self.leading = lc
            }
            else if lc.firstAttribute == .Trailing{
                self.tralling = lc
            }
            else if lc.firstAttribute == .CenterX{
                self.centerX = lc
            }
            else if lc.firstAttribute == .CenterY{
                self.centerY = lc
            }
            else if lc.firstAttribute == .Width{
                if lc.secondAttribute == .NotAnAttribute{
                    self.specifiedWidth = lc
                }
                else{
                    self.relativeWidth = lc
                }
            }
            else if lc.firstAttribute == .Height{
                if lc.secondAttribute == .NotAnAttribute{
                    self.specifiedHeight = lc
                }
                else{
                    self.relativeHeight = lc
                }
            }
        }
    }
    
    init(cs : [NSLayoutConstraint]){
        for lc in cs {
            if lc.firstAttribute == .Top{
                self.top = lc
            }
            else if lc.firstAttribute == .Bottom{
                self.bottom = lc
            }
            else if lc.firstAttribute == .Leading{
                self.leading = lc
            }
            else if lc.firstAttribute == .Trailing{
                self.tralling = lc
            }
            else if lc.firstAttribute == .CenterX{
                self.centerX = lc
            }
            else if lc.firstAttribute == .CenterY{
                self.centerY = lc
            }
            else if lc.firstAttribute == .Width{
                if lc.secondAttribute == .NotAnAttribute{
                    self.specifiedWidth = lc
                }
                else{
                    self.relativeWidth = lc
                }
            }
            else if lc.firstAttribute == .Height{
                if lc.secondAttribute == .NotAnAttribute{
                    self.specifiedHeight = lc
                }
                else{
                    self.relativeHeight = lc
                }
            }
        }
    }
    
    init(){
        
    }
}

////MARK: - 扩展属性
//extension UIView{
//    /**
//     *  @author Five, 16-03-25 15:03:37
//     *
//     *  扩展属性Key
//     */
//    private struct AssociatedKeysForUIView {
//        static var showAndHideOptions = "showAndHideOptions"//视图弹出、隐藏参数
//        
//        static var isShowing = "isShowing"//是否正在显示
//        
//        static var maskButton = "maskButton"//遮罩层
//        
//        static var showCompeleted = "showCompeleted"//显示完毕
//        static var hideCompleted = "hideCompleted"//隐藏完毕
//        static var maskClick = "maskClick"//遮罩层点击事件
//    }
//}


// MARK: - 在父容器中弹出自己
extension UIView{
    
    /**
     在父容器中弹出自己
     
     - parameter superUV:       父容器
     - parameter showStyle:     显示样式
     - parameter hideStyle:     隐藏样式
     - parameter options:       约束
     - parameter maskStyle:     遮罩层样式
     
     - returns: 成功与否
     */
    func showInViewOC(superUV: UIView, showStyle: CNShowOrHideStyleOC, hideStyle: CNShowOrHideStyleOC, options: [NSLayoutConstraint], maskStyle : CNMaskStyleOC) -> Bool{
        var op = ViewShowAndHideOptionsOC(cs : options);
        
        op.superUV = superUV
        op.showStyle = showStyle
        op.hideStyle = hideStyle
        op.maskStyle = maskStyle
        
        return self.showInView(op)
    }
    
    /**
     在父容器中弹出自己
     
     - parameter options: 参数
     
     - returns: 成功与否
     */
    func showInView(options: ViewShowAndHideOptionsOC) -> Bool{
        
        let op = ViewShowAndHideOptions(ocOptions: options)
        
        return self.showInView(op)
    }
}

extension UIView{
    /**
     从父容器中隐藏自己
     
     - parameter hideStyle:          隐藏样式
     - parameter animated:           是否启用动画
     - parameter removeAfterComplet: 动画结束，是否从父容器中移除自己
     - parameter complete:           隐藏完毕回调
     */
    func hideFromSuperViewOC(hideStyle: CNShowOrHideStyleOC, animated: Bool, removeAfterComplete: Bool, complete:noParamNoReturn?){
        var shStyle:CNShowOrHideStyle =  .None
        
        switch hideStyle {
        case CNShowOrHideStyleOC.Top:
            shStyle = .Top
        case CNShowOrHideStyleOC.Bottom:
            shStyle = .Bottom
        case CNShowOrHideStyleOC.Right:
            shStyle = .Right
        case CNShowOrHideStyleOC.Left:
            shStyle = .Left
        case CNShowOrHideStyleOC.None: break
        default: break
        }
        
        
        self.hideFromSuperView(shStyle, animated: animated, removeAfterComplete: removeAfterComplete, complete: complete)
    }
}