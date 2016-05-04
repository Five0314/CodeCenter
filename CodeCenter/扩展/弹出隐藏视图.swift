//
//  UIView_Five0314.swift
//  Test
//
//  Created by Five0314 on 16/3/18.
//  Copyright © 2016年 Five0314. All rights reserved.
//

import UIKit

//MARK: - 枚举 视图弹出、隐藏方向
/// 显示、隐藏 类型
enum CNShowStyle: UInt{
    case None = 0
    case Top = 1
    case Bottom = 2
    case Left = 3
    case Right = 4
    
    func ocValue() -> CNShowOrHideStyleOC{
        return CNShowOrHideStyleOC(rawValue: self.rawValue)
    }
}

enum CNHideStyle: UInt{
    case None = 0
    case Top = 1
    case Bottom = 2
    case Left = 3
    case Right = 4
    
    func ocValue() -> CNShowOrHideStyleOC{
        return CNShowOrHideStyleOC(rawValue: self.rawValue)
    }
}

//MARK: - 显示视图的进入动画样式
/**
 显示视图的进入动画样式
 
 - SpringAnimation:   弹簧效果
 - LineAnimation: 线性动画
 */
enum CNShowAnimationStyle{
    case SpringAnimation
    case LineAnimation
}

//MARK: - 结构体 遮罩层类型
/// 遮罩层类型
public struct CNMaskStyle: OptionSetType{
    public var rawValue: Int
    
    public init(rawValue: Int){
        self.rawValue = rawValue
    }
    
    /// 无
    static var None:CNMaskStyle {return CNMaskStyle(rawValue: 0)}
    
    /// 添加背景
    static var Add:CNMaskStyle {return CNMaskStyle(rawValue: 1)}
    
    /// 背景可见
    static var Show:CNMaskStyle {return CNMaskStyle(rawValue: 1 << 1)}
    
    /// 背景可点击
    static var ClickEnable:CNMaskStyle {return CNMaskStyle(rawValue: 1 << 2)}
}

//MARK: - 视图弹出参数
/// 仅仅为了Runtime保存使用，Runtime暂时无法保存Struct，顾使用类封装之后保存
private class ViewOptionsForShowAndHide{
    let option: ViewShowAndHideOptions
    
    init(viewOptions: ViewShowAndHideOptions){
        self.option = viewOptions
    }
}

/// showInView.options
struct ViewShowAndHideOptions{
//MARK: 进入方向
    /// 进入方向
    var showStyle: CNShowStyle = .Right
    
//    var showAnimationStyle: 
    
//MARK: 隐藏方向
    /// 隐藏方向
    var hideStyle: CNHideStyle = .Right
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
    var maskStyle: CNMaskStyle = [.Add, .Show, .ClickEnable];
    
    init(){}
    
    init(superUV: UIView?, showStyle: CNShowStyle, hideStyle: CNHideStyle, masktype: CNMaskStyle, cs : [NSLayoutConstraint]){
        self.superUV = superUV
        
        self.showStyle = showStyle
        
        self.hideStyle = hideStyle
        
        self.maskStyle = masktype
        
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
    
    init(ocOptions : ViewShowAndHideOptionsOC){
        //父容器
        self.superUV = ocOptions.superUV
//        self.showStyle = ocOptions.showStyle.rawValue
        //显示样式
        switch ocOptions.showStyle {
        case CNShowOrHideStyleOC.None:
            self.showStyle = .None
        case CNShowOrHideStyleOC.Top:
            self.showStyle = .Top
        case CNShowOrHideStyleOC.Bottom:
            self.showStyle = .Bottom
        case CNShowOrHideStyleOC.Left:
            self.showStyle = .Left
        case CNShowOrHideStyleOC.Right:
            self.showStyle = .Right
        default:break
        }
        
        //隐藏样式
        switch ocOptions.hideStyle {
        case CNShowOrHideStyleOC.None:
            self.hideStyle = .None
        case CNShowOrHideStyleOC.Top:
            self.hideStyle = .Top
        case CNShowOrHideStyleOC.Bottom:
            self.hideStyle = .Bottom
        case CNShowOrHideStyleOC.Left:
            self.hideStyle = .Left
        case CNShowOrHideStyleOC.Right:
            self.hideStyle = .Right
        default:break
        }
        
        //遮罩层样式
        self.maskStyle.rawValue = Int(ocOptions.maskStyle.rawValue)
        
        //约束
        self.top = ocOptions.top
        self.bottom = ocOptions.bottom
        self.tralling = ocOptions.tralling
        self.leading = ocOptions.leading
        self.centerX = ocOptions.centerX
        self.centerY = ocOptions.centerY
        self.relativeWidth = ocOptions.relativeWidth
        self.relativeHeight = ocOptions.relativeHeight
        self.specifiedWidth = ocOptions.specifiedWidth
        self.specifiedHeight = ocOptions.specifiedHeight
    }
}

//MARK: - 扩展属性
extension UIView{
    /**
     *  @author Five, 16-03-25 15:03:37
     *
     *  扩展属性Key
     */
    private struct AssociatedKeysForUIView {
        static var showAndHideOptions = "showAndHideOptions"//视图弹出、隐藏参数
        
        static var isShowing = "isShowing"//是否正在显示
        
        static var maskButton = "maskButton"//遮罩层
        
        static var showCompeleted = "showCompeleted"//显示完毕
        static var hideCompleted = "hideCompleted"//隐藏完毕
        static var maskClick = "maskClick"//遮罩层点击事件
    }
    
    /// 视图弹出、隐藏参数
    var showAndHideOptions: ViewShowAndHideOptions?{
        get{
            if let v = objc_getAssociatedObject(self, &AssociatedKeysForUIView.showAndHideOptions){
                return (v as! ViewOptionsForShowAndHide).option
            }
            else{
                return nil
            }
        }
        set{
            if newValue != nil{
                objc_setAssociatedObject(self, &AssociatedKeysForUIView.showAndHideOptions, ViewOptionsForShowAndHide(viewOptions: newValue!), .OBJC_ASSOCIATION_RETAIN)
            }
            else{
                objc_setAssociatedObject(self, &AssociatedKeysForUIView.showAndHideOptions, nil, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
    
    /// 是否正在显示
    var hasBeDisplayedFromShowInView: Bool{
        get{
            if let v = objc_getAssociatedObject(self, &AssociatedKeysForUIView.isShowing){
                return v.boolValue
            }
            else{
                return false
            }
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeysForUIView.isShowing, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// 遮罩层
    var maskButton: UIButton?{
        set{
            objc_setAssociatedObject(self, &AssociatedKeysForUIView.maskButton, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return unsafeBitCast(objc_getAssociatedObject(self, &AssociatedKeysForUIView.maskButton), UIButton.self)
        }
    }
    
    /// 隐藏完毕回调
    var hideCompleted: noParamNoReturn?{
        set{
            objc_setAssociatedObject(self, &AssociatedKeysForUIView.hideCompleted, unsafeBitCast(newValue, AnyObject.self), .OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return unsafeBitCast(objc_getAssociatedObject(self, &AssociatedKeysForUIView.hideCompleted), noParamNoReturn.self)
        }
    }
    
    /// 显示完毕回调
    var showCompleted: noParamNoReturn?{
        set{
            objc_setAssociatedObject(self, &AssociatedKeysForUIView.showCompeleted, unsafeBitCast(newValue, AnyObject.self), .OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return unsafeBitCast(objc_getAssociatedObject(self, &AssociatedKeysForUIView.showCompeleted), noParamNoReturn.self)
        }
    }
    
    /// 显示完毕回调
    var maskClick: noParamNoReturn?{
        set{
            objc_setAssociatedObject(self, &AssociatedKeysForUIView.maskClick, unsafeBitCast(newValue, AnyObject.self), .OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return unsafeBitCast(objc_getAssociatedObject(self, &AssociatedKeysForUIView.maskClick), noParamNoReturn.self)
        }
    }
}

//MARK : - 闭包类型定义
typealias noParamNoReturn = @convention(block) () -> Void

// MARK: - 在父容器中弹出自己
extension UIView{

    /**
     在父容器中弹出自己
     
     - parameter superUV:       父容器
     - parameter showStyle:     弹出样式
     - parameter hideStyle:     隐藏样式
     - parameter options:       约束
     
     - returns: 成功与否
     */
    func showInView(superUV: UIView, showStyle: CNShowStyle, hideStyle: CNHideStyle, options: [NSLayoutConstraint]) -> Bool{
        var op = ViewShowAndHideOptions(cs : options);
        op.superUV = superUV
        op.showStyle = showStyle
        op.hideStyle = hideStyle
        
        return self.showInView(op)
    }
    
    /**
     在父容器中弹出自己
     
     - parameter options: 参数
     
     - returns: 成功与否
     */
    func showInView(options: ViewShowAndHideOptions) -> Bool{
        if options.superUV == nil{//没有父容器，返回false
            return false
        }
        
        //记录显示、隐藏参数
        self.showAndHideOptions = options
        
        let _:AnyObject = NSValue()
        
        // 遮罩层
        if options.maskStyle != .None{
            // 遮罩层输初始化
            let mb = UIButton();
            self.maskButton = mb
            mb.alpha = 0.0
            options.superUV?.addSubview(mb)
            
            // 约束
            mb.translatesAutoresizingMaskIntoConstraints = false
            let ct = mb.constraints(options.superUV, top: 0, bottom: 0, leading: 0, trailing: 0)
            options.superUV?.addConstraints(ct)
            
            // 遮罩层颜色
            if options.maskStyle.contains(.Show){
                mb.backgroundColor = RGB(85, green: 85, blue: 85, alpha: 0.6)
            }
            else{
                mb.backgroundColor = UIColor.clearColor()
            }
            
            // 遮罩层点击事件
            if options.maskStyle.contains(.ClickEnable){
                mb.addTarget(self, action: #selector(self.cnMaskButtonClicked(_:)), forControlEvents: .TouchUpInside)
//                mb.addTarget(self, action: #selector(cnMaskButtonClicked), forControlEvents: .TouchUpInside)
            }
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //如果自己已经有父容器了，且父容器不是目标弹出父容器，返回false
        if self.superview != nil && self.superview != options.superUV{
            return false
        }
        
        //如果options.superView不是自己的父容器，则添加之
        if self.superview != options.superUV{
            options.superUV?.addSubview(self)
        }
        
        //约束
        options.top?.active = true
        options.bottom?.active = true
        options.leading?.active = true
        options.tralling?.active = true
        options.relativeWidth?.active = true
        options.relativeHeight?.active = true
        options.centerX?.active = true
        options.centerY?.active = true
        options.specifiedWidth?.active = true
        options.specifiedHeight?.active = true
        
        //执行约束
        self.layoutIfNeeded()
        self.superview!.layoutIfNeeded()
        
        //初始偏移量
        switch options.showStyle {
        case .Top:
            self.transform = CGAffineTransformMakeTranslation(0, self.transform.ty - self.bounds.size.height - self.frame.origin.y);
        case .Bottom:
            if options.superUV != nil{
                self.transform = CGAffineTransformMakeTranslation(0, self.transform.ty + options.superUV!.bounds.size.height - self.frame.origin.y);
            }
        case .Left:
            self.transform = CGAffineTransformMakeTranslation(self.transform.tx - self.bounds.size.width - self.frame.size.width, 0);
        case .Right:
            if options.superUV != nil{
                self.transform = CGAffineTransformMakeTranslation(self.transform.tx + options.superUV!.bounds.size.width - self.bounds.origin.x - self.transform.tx, 0);
            }
        default: break
        }
        
        UIView.animateWithDuration(0.25, animations: {
            if self.maskButton != nil{
                self.maskButton?.alpha = 1.0
            }
            }, completion: nil)
        
        //动画
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.68, initialSpringVelocity: 0.0, options: [.BeginFromCurrentState, .AllowUserInteraction], animations: {
            self.transform =  CGAffineTransformMakeTranslation(0, 0);
        }) {(finished) in
            
            //显示中
            self.hasBeDisplayedFromShowInView = true
            
            //显示完毕回调
            if self.showCompleted != nil{
                self.showCompleted!()
            }
        }
        
        return true
    }
    
    // MARK: 遮罩层点击事件
    @objc private func cnMaskButtonClicked(sender: UIButton){
        if self.maskClick != nil{
            self.maskClick!()
        }
        else{
            self.hideFromSuperView()
        }
    }
}

// MARK: - 从父容器中隐藏自己
extension UIView{
    
    /**
     从父容器中隐藏自己
     */
    func hideFromSuperView(){
        if self.showAndHideOptions != nil{
            self.hideFromSuperView(self.showAndHideOptions?.hideStyle, animated: true, removeAfterComplete: true, complete: nil)
        }
        else{
            self.hideFromSuperView(.Right, animated: true, removeAfterComplete: true, complete: nil)
        }
    }
    
    /**
     从父容器中隐藏自己
     
     - parameter complete: 隐藏完毕回调
     */
    func hideFromSuperView(complete: noParamNoReturn){
        if self.showAndHideOptions != nil{
            self.hideFromSuperView(self.showAndHideOptions?.hideStyle, animated: true, removeAfterComplete: true, complete: complete)
        }
        else{
            self.hideFromSuperView(.Right, animated: true, removeAfterComplete: true, complete: complete)
        }
    }
    
    /**
     从父容器中隐藏自己
     
     - parameter hideStyle:          隐藏样式
     - parameter animated:           是否启用动画
     - parameter removeAfterComplet: 动画结束，是否从父容器中移除自己
     - parameter complete:           隐藏完毕回调
     */
    func hideFromSuperView(hideStyle: CNHideStyle?, animated: Bool, removeAfterComplete: Bool, complete:noParamNoReturn?){
        var duration = 0.25
        if hideStyle == nil || hideStyle == .None{
            duration = 0.5
        }
        
        if !animated{
            duration = 0;
        }
        
        //动画
        UIView.animateWithDuration(duration, animations: {
//        UIView.animateWithDuration(animated ? 0.68 : 0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.1, options: [.BeginFromCurrentState, .AllowUserInteraction], animations: {
            /**
             *  遮罩层
             */
            if self.maskButton != nil{
                self.maskButton?.alpha = 0
            }
            
            //偏移量
            if hideStyle != nil{
                switch hideStyle! {
                case .None:
                    self.layer.zPosition = 1000
                    
                    var transform3D = CATransform3DMakeRotation(CGFloat(M_PI), 0.0, -1.0, 0.0)
                    transform3D.m34 = 1.0 / 700
                    
                    transform3D = CATransform3DScale(transform3D, 0.15, 0.15, 1)
                    
                    self.layer.transform = transform3D
                    
                    self.alpha = 0
                case .Top:
                    self.transform = CGAffineTransformMakeTranslation(0, 0 - self.bounds.size.height - self.frame.origin.y);
                case .Bottom:
                    if self.superview != nil{
                        self.transform = CGAffineTransformMakeTranslation(0, self.superview!.bounds.size.height - self.frame.origin.y);
                    }
                case .Left:
                    self.transform = CGAffineTransformMakeTranslation(0 - self.bounds.size.width - self.frame.size.width, 0);
                case .Right:
                    if self.superview != nil{
                        self.transform = CGAffineTransformMakeTranslation(self.superview!.bounds.size.width - self.bounds.origin.x, 0);
                    }
                }
            }
            else{
                self.layer.zPosition = 1000
                
                var transform3D = CATransform3DMakeRotation(CGFloat(M_PI), 0.0, -1.0, 0.0)
                transform3D.m34 = 1.0 / 500
                
                transform3D = CATransform3DScale(transform3D, 0.01, 0.01, 1)
                
                self.layer.transform = transform3D
                
                self.alpha = 0
            }
            
        }) {(finished) in
            
            if self.maskButton != nil{
                self.maskButton?.removeFromSuperview()
            }
            
            if removeAfterComplete{
                self.removeFromSuperview()
            }
            else{
                self.superview?.sendSubviewToBack(self)
            }
            
            //还原缩放、偏移、旋转...
            self.layer.transform = CATransform3DIdentity
            self.transform = CGAffineTransform()
            
            //非显示中
            self.hasBeDisplayedFromShowInView = false
            
            if complete != nil{
                complete!()
            }
            
            if self.hideCompleted != nil{
                self.hideCompleted!()
            }
        }
    }
}
