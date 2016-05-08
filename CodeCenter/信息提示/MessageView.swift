//
//  MessageView.swift
//  BusinessTime
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 kaifa24. All rights reserved.
//

import UIKit

///属性值变更
typealias propertyChange = @convention(block) (propertyName: NSString) -> Void

///按钮点击回调
typealias buttonClick = @convention(block) (textValue: NSString) -> Void

class CNKVOProperty: NSObject{
    var propertyValueChanged: propertyChange?
}

class CNConstraintProperty: CNKVOProperty{
    var top: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "top")
            }
        }
    }
    var bottom: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "bottom")
            }
        }
    }
    var leading: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "leading")
            }
        }
    }
    var trailing: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "trailing")
            }
        }
    }
}

class CNLabelProperty: CNConstraintProperty{

    var textAlignment:NSTextAlignment = .Center{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "textAlignment")
            }
        }
    }
    var textColor:UIColor?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "textColor")
            }
        }
    }
    var font:UIFont?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "font")
            }
        }
    }
    var text:String?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "text")
            }
        }
    }
    var regularExpression:String?{//正则（高亮匹配到的字符串）
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "regularExpression")
            }
        }
    }
    var highlightColor:UIColor?{//高亮的颜色
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "highlightColor")
            }
        }
    }
}

///标题
class CNMessageViewTitleProperty: CNLabelProperty{
    ///分割线
    let separator: CNSeparatorProperty = CNSeparatorProperty()
}

///按钮
class CNMessageViewMessage: CNKVOProperty{
    ///TopMessage
    let topMessage: CNLabelProperty = CNLabelProperty()
    
    ///BottomMessage
    let bottomMessage: CNLabelProperty = CNLabelProperty()
}

//分割线
class CNSeparatorProperty: CNKVOProperty{
    var leading: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "leading")
            }
        }
    }
    var trailing: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "trailing")
            }
        }
    }
    var bottom: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "bottom")
            }
        }
    }
    var fillColor:UIColor?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "fillColor")
            }
        }
    }
    
    var enable:Bool?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "enable")
            }
        }
    }
}

///文本输入框
class CNTextFieldProperty: CNLabelProperty{
    var placeholder:String?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "placeholder")
            }
        }
    }
    var borderStyle:UITextBorderStyle?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "borderStyle")
            }
        }
    }
    
    var enable:Bool = false{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "enable")
            }
        }
    }
}

///按钮
class CNButtonProperty: CNKVOProperty{
    var titleColor:UIColor?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "titleColor")
            }
        }
    }
    var font:UIFont?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "font")
            }
        }
    }
    var title:String?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "title")
            }
        }
    }
    var enable:Bool = true{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "enable")
            }
        }
    }
}

///按钮
class CNMessageViewButton: CNKVOProperty{
    let leftButton: CNButtonProperty = CNButtonProperty()
    
    let rightButton: CNButtonProperty = CNButtonProperty()
}

//struct MessageViewButtonStyle : OptionSetType{
//    let rawValue: UInt
//    
//    init(rawValue: UInt){
//        self.rawValue = rawValue
//    }
//    
//    static var None:MessageViewButtonStyle {return MessageViewButtonStyle(rawValue: 0)}
//    
//    static var Left:MessageViewButtonStyle {return MessageViewButtonStyle(rawValue: 1)}
//    
//    static var Right:MessageViewButtonStyle {return MessageViewButtonStyle(rawValue: 1 << 1)}
//    
//    static var LeftAndRight:MessageViewButtonStyle {return MessageViewButtonStyle(rawValue: 1 | 1 << 1)}
//}

class MessageView: UIView {
    
    /// 标题
    let title = CNMessageViewTitleProperty()
    
    /// 输入框
    let textField = CNTextFieldProperty()
    
    ///信息
    let messages: CNMessageViewMessage = CNMessageViewMessage()
    
    ///按钮
    let buttons: CNMessageViewButton = CNMessageViewButton()
    
//    /// 左边的Button
//    let leftButton = CNButtonProperty()
    
//    /// 右边的Button
//    let rightButton = CNButtonProperty()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.reset()//重置控件
        self.addCNKVO()//添加KVO
        
        self.rightButtonControl//只要实例化任何一个Button，会以为关联调用而全部被初始化
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.reset()//重置控件
        self.addCNKVO()//添加KVO
        
        self.rightButtonControl//只要实例化任何一个Button，会以为关联调用而全部被初始化
        
//        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("deinit")
    }
    
    //MARK: - 添加KVO
    private func addCNKVO(){
        
        title.propertyValueChanged = {[unowned self] (propertyName: NSString) in
            switch propertyName {
            case "top":
                self.titleTopConstraint?.constant = CGFloat(self.title.top)
                break
                
            case "bottom":
                self.titleBottomConstraint?.constant = CGFloat(-self.title.bottom)
                break
                
            case "leading":
                self.titleLeadingConstraint?.constant = CGFloat(self.title.leading)
                break
                
            case "trailing":
                self.titleTrailingConstraint?.constant = CGFloat(-self.title.trailing)
                break
                
            case "text":
                if let atrributeText = self.stringWithRegular(self.title.text, regular: self.title.regularExpression, highlightColor: self.title.highlightColor){
                    self.titleLabelControl.attributedText = atrributeText
                }
                else{
                    self.titleLabelControl.attributedText = nil
                    self.titleLabelControl.text = self.title.text
                }
                break
                
            case "textColor":
                self.titleLabelControl.textColor = self.title.textColor
                break
                
            case "textAlignment":
                self.titleLabelControl.textAlignment = self.title.textAlignment
                break
                
            case "font":
                self.titleLabelControl.font = self.title.font
                break
                
            case "regularExpression":
                self.title.text = self.title.text
                break
                
            case "highlightColor":
                self.title.text = self.title.text
                break
                
            default: break
            }
        }
        
        //Title的分割线
        title.separator.propertyValueChanged = {[unowned self] (propertyName: NSString) in
            switch propertyName {
            case "bottom":
                self.titleSeperatorBottomConstraint?.constant = CGFloat(-self.title.separator.bottom)
                break
                
            case "leading":
                self.titleLeadingConstraint?.constant = CGFloat(self.title.separator.leading)
                break
                
            case "trailing":
                self.titleTrailingConstraint?.constant = CGFloat(-self.title.separator.trailing)
                break
                
            case "enable":
                self.titleSeperator.hidden = !self.title.separator.enable!
                break
                
            case "fillColor":
                self.titleSeperator.backgroundColor = self.title.separator.fillColor
                break

            default: break
            }
        }
        
        self.messages.topMessage.propertyValueChanged = {[unowned self] (propertyName: NSString) in
            
            switch propertyName {
            case "top":
                self.topMessageTopConstraint?.constant = CGFloat(self.messages.topMessage.top)
                break
                
            case "bottom":
                self.topMessageBottomConstraint?.constant = CGFloat(-self.messages.topMessage.bottom)
                break
                
            case "leading":
                self.topMessageLeadingConstraint?.constant = CGFloat(self.messages.topMessage.leading)
                break
                
            case "trailing":
                self.topMessageTrailingConstraint?.constant = CGFloat(-self.messages.topMessage.trailing)
                break
                
            case "text":
                if let atrributeText = self.stringWithRegular(self.messages.topMessage.text, regular: self.messages.topMessage.regularExpression, highlightColor: self.messages.topMessage.highlightColor){
                    self.topMessageLabelControl.attributedText = atrributeText
                }
                else{
                    self.topMessageLabelControl.text = self.messages.topMessage.text
                    self.updateTitleSeparator()//更新标题分割线
                }
                break
                
            case "textColor":
                self.topMessageLabelControl.textColor = self.messages.topMessage.textColor
                break
                
            case "textAlignment":
                self.topMessageLabelControl.textAlignment = self.messages.topMessage.textAlignment
                break
                
            case "font":
                self.topMessageLabelControl.font = self.messages.topMessage.font
                break
                
            case "regularExpression":
                self.messages.topMessage.text = self.messages.topMessage.text
                break
                
            case "highlightColor":
                self.messages.topMessage.text = self.messages.topMessage.text
                break
                
            default: break
            }
            
        }
        
        textField.propertyValueChanged = {[unowned self] (propertyName: NSString) in
            switch propertyName {
            case "top":
                self.textFieldTopConstraint?.constant = CGFloat(self.textField.top)
                break
                
            case "bottom":
                self.textFieldBottomConstraint?.constant = CGFloat(-self.textField.bottom)
                break
                
            case "leading":
                self.textFieldLeadingConstraint?.constant = CGFloat(self.textField.leading)
                break
                
            case "trailing":
                self.textFieldTrailingConstraint?.constant = CGFloat(-self.textField.trailing)
                break
                
            case "text":
                self.textFieldControl.text = self.textField.text
                break
                
            case "textColor":
                self.textFieldControl.textColor = self.textField.textColor
                break
                
            case "textAlignment":
                self.textFieldControl.textAlignment = self.textField.textAlignment
                break
                
            case "font":
                self.textFieldControl.font = self.textField.font
                break
                
            case "placeholder":
                self.textFieldControl.placeholder = self.textField.placeholder
                break
                
            case "borderStyle":
                self.textFieldControl.borderStyle = self.textField.borderStyle!
                break
                
            case "enable":
                self.textFieldHeightConstraint?.constant = self.textField.enable ? 38.0 : 0
                
                self.updateTitleSeparator()//更新标题分割线
                break
                
            default: break
            }
        }
        
        self.messages.bottomMessage.propertyValueChanged = {[unowned self] (propertyName: NSString) in
            switch propertyName {
            case "top":
                self.bottomMessageTopConstraint?.constant = CGFloat(self.messages.bottomMessage.top)
                break
                
            case "bottom":
                self.bottomMessageBottomConstraint?.constant = CGFloat(-self.messages.bottomMessage.bottom)
                break
                
            case "leading":
                self.bottomMessageLeadingConstraint?.constant = CGFloat(self.messages.bottomMessage.leading)
                break
                
            case "trailing":
                self.bottomMessageTrailingConstraint?.constant = CGFloat(-self.messages.bottomMessage.trailing)
                break
                
            case "text":
                if let atrributeText = self.stringWithRegular(self.messages.bottomMessage.text, regular: self.messages.bottomMessage.regularExpression, highlightColor: self.messages.bottomMessage.highlightColor){
                    self.bottomMessageLabelControl.attributedText = atrributeText
                }
                else{
                    self.bottomMessageLabelControl.text = self.messages.bottomMessage.text
                    self.updateTitleSeparator()//更新标题分割线
                }
                break
                
            case "textColor":
                self.bottomMessageLabelControl.textColor = self.messages.bottomMessage.textColor
                break
                
            case "textAlignment":
                self.bottomMessageLabelControl.textAlignment = self.messages.bottomMessage.textAlignment
                break
                
            case "font":
                self.bottomMessageLabelControl.font = self.messages.bottomMessage.font
                break
                
            case "regularExpression":
                self.messages.bottomMessage.text = self.messages.bottomMessage.text
                break
                
            case "highlightColor":
                self.messages.bottomMessage.text = self.messages.bottomMessage.text
                break
                
            default: break
            }
        }
        
        self.buttons.rightButton.propertyValueChanged = {[unowned self] (propertyName: NSString) in
            switch propertyName {
            case "title":
                self.rightButtonControl.setTitle(self.buttons.rightButton.title, forState: .Normal)
                break
                
            case "titleColor":
                self.rightButtonControl.setTitleColor(self.buttons.rightButton.titleColor, forState: .Normal)
                break

            case "font":
                self.rightButtonControl.titleLabel?.font = self.buttons.rightButton.font
                break
                
            case "enable":
                self.rightButtonControl.hidden = !self.buttons.rightButton.enable//右边按钮不可用的时候隐藏
                if(self.buttons.rightButton.enable){//右边按钮可用
                    if(self.buttons.leftButton.enable){//如果左边按钮可用，则右边按钮只占一半的宽度
                        self.rightButtonWidthConstraint_PanelWidth?.active = false
                        self.rightButtonWidthConstraint_PanelHalfWidth?.active = true
                    }
                    else{//否则右边按钮的宽度 == 按钮容器的宽度
                        self.rightButtonWidthConstraint_PanelWidth?.active = true
                        self.rightButtonWidthConstraint_PanelHalfWidth?.active = false
                    }
                }
                
                self.leftButtonControl.hidden = !self.buttons.leftButton.enable//左边按钮不可用的时候隐藏
                if(self.buttons.leftButton.enable){//左边按钮可用
                    if(self.buttons.rightButton.enable){//如果右边按钮可用，则左边按钮只占一半的宽度
                        self.leftButtonWidthConstraint_PanelWidth?.active = false
                        self.leftButtonWidthConstraint_PanelHalfWidth?.active = true
                    }
                    else{//否则右左边按钮的宽度 == 按钮容器的宽度
                        self.leftButtonWidthConstraint_PanelWidth?.active = true
                        self.leftButtonWidthConstraint_PanelHalfWidth?.active = false
                    }
                }
                
                //只有左右两个按钮同时可用的时候，才需要显示垂直的分割线
                if(self.buttons.rightButton.enable && self.buttons.leftButton.enable){
                    self.buttonVerticalSeparator.hidden = false
                }
                else{
                    self.buttonVerticalSeparator.hidden = true
                }
                
                //只要有一个按钮可用，那么按钮容器的高度就得为44，否则为0
                if (self.buttons.rightButton.enable || self.buttons.leftButton.enable){
                    self.buttonPanelHeightConstraint?.constant = 44
                }
                else{
                    self.buttonPanelHeightConstraint?.constant = 0
                }
                
                break
                
            default: break
            }
        }
        
        self.buttons.leftButton.propertyValueChanged = {[unowned self] (propertyName: NSString) in
            switch propertyName {
            case "title":
                self.leftButtonControl.setTitle(self.buttons.leftButton.title, forState: .Normal)
                break
                
            case "titleColor":
                self.leftButtonControl.setTitleColor(self.buttons.leftButton.titleColor, forState: .Normal)
                break
                
            case "font":
                self.leftButtonControl.titleLabel?.font = self.buttons.leftButton.font
                break
                
            case "enable":
                self.buttons.rightButton.enable = self.buttons.rightButton.enable
                break
                
            default: break
            }
        }
    }
    
    //MARK: - 重置控件
    func reset(){
        //背景色
        self.backgroundColor = UIColor.whiteColor()
        
        //圆角
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        //标题
        self.title.top = 10.0
        self.title.bottom = 10.0
        self.title.leading = 8.0
        self.title.trailing = 8.0
        self.title.textColor = UIColor.blackColor()
        self.title.textAlignment = .Center
        self.title.font = UIFont.systemFontOfSize(20.0)
//        self.title.highlightColor = UIColor(red: 0 / 255.0, green: 122 / 255.0, blue: 255 / 255.0, alpha: 1.0)
//        self.title.regularExpression = "“((?!”.*“).)+”"
        
        self.title.separator.leading = 8.0
        self.title.separator.trailing = 8.0
        self.title.separator.fillColor = UIColor(red: 234 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, alpha: 1.0)
        self.title.separator.enable = false
        
        //TopMessage
        self.messages.topMessage.top = 25.0
        self.messages.topMessage.bottom = 25.0
        self.messages.topMessage.leading = 8.0
        self.messages.topMessage.trailing = 8.0
        self.messages.topMessage.text = nil
        self.messages.topMessage.textColor = UIColor(red: 74 / 255.0, green: 74 / 255.0, blue: 74 / 255.0, alpha: 1.0)
        self.messages.topMessage.textAlignment = .Center
        self.messages.topMessage.font = UIFont.systemFontOfSize(16.0)
        
        //TextField
        self.textField.top = 0.0
        self.textField.bottom = 0.0
        self.textField.leading = 8.0
        self.textField.trailing = 8.0
        self.textField.text = nil
        self.textField.textColor = UIColor.blackColor()
        self.textField.textAlignment = .Left
        self.textField.font = UIFont.systemFontOfSize(16.0)
        self.textField.placeholder = "请输入"
        self.textField.borderStyle = .RoundedRect
        self.textField.enable = false
        
        //BottomMessage
        self.messages.bottomMessage.top = 15.0
        self.messages.bottomMessage.bottom = 15.0
        self.messages.bottomMessage.leading = 8.0
        self.messages.bottomMessage.trailing = 8.0
        self.messages.bottomMessage.text = nil
        self.messages.bottomMessage.textColor = UIColor(red: 74 / 255.0, green: 74 / 255.0, blue: 74 / 255.0, alpha: 1.0)
        self.messages.bottomMessage.textAlignment = .Left
        self.messages.bottomMessage.font = UIFont.systemFontOfSize(16.0)
        
        //LeftButton
        self.buttons.leftButton.enable = true
        self.buttons.leftButton.title = "取消"
        self.buttons.leftButton.titleColor = UIColor.lightGrayColor()
        self.buttons.leftButton.font = UIFont.systemFontOfSize(16.0)
        
        //RightButton
        self.buttons.rightButton.enable = true
        self.buttons.rightButton.title = "确定"
        self.buttons.rightButton.titleColor = UIColor(red: 0 / 255.0, green: 122 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        self.buttons.rightButton.font = UIFont.systemFontOfSize(16.0)
    }
    
    //MARK: - 高亮字符串
    func stringWithRegular(text: String?, regular: String?, highlightColor: UIColor?) -> NSMutableAttributedString?{
        if text == nil || regular == nil || highlightColor == nil{
            return nil
        }
        
        do{
            let regex = try NSRegularExpression(pattern: regular!, options: .CaseInsensitive)
            let regularResult = regex.matchesInString(text!, options: .ReportCompletion, range: NSMakeRange(0, text!.characters.count))
            
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
    
    //MARK: - 标题
    
    private var _titlePanel:UIView?{
        didSet{
            //背景色
            _titlePanel!.backgroundColor = UIColor.clearColor()
            
            //超过边界不可见
            _titlePanel?.clipsToBounds = true
            
            self.addSubview(_titlePanel!)
            _titlePanel?.translatesAutoresizingMaskIntoConstraints = false

            //Top
            let topCS = NSLayoutConstraint.init(item: _titlePanel!, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0)
            topCS.active = true
            
            //Leading
            let leadingCS = NSLayoutConstraint.init(item: _titlePanel!, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0)
            leadingCS.active = true
            
            //Trailing
            let trailingCS = NSLayoutConstraint.init(item: _titlePanel!, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0)
            trailingCS.active = true
        }
    }
    private var titlePanel:UIView{
        get{
            if(_titlePanel == nil){
                _titlePanel = UIView()
            }
            
            return _titlePanel!
        }
    }
    
    private var _titleLabelControl:UILabel!{
        didSet{
            //背景色
            _titleLabelControl.backgroundColor = UIColor.clearColor()
            
            //不限定行数
            _titleLabelControl.numberOfLines = 0
            
            self.addSubview(_titleLabelControl)
            _titleLabelControl.translatesAutoresizingMaskIntoConstraints = false

            //Top
            self.titleTopConstraint = NSLayoutConstraint.init(item: _titleLabelControl, attribute: .Top, relatedBy: .Equal, toItem: self.titlePanel, attribute: .Top, multiplier: 1.0, constant: CGFloat(self.title.top))
            self.titleTopConstraint?.active = true
            
            //bottom
            self.titleBottomConstraint = NSLayoutConstraint.init(item: _titleLabelControl, attribute: .Bottom, relatedBy: .Equal, toItem: self.titlePanel, attribute: .Bottom, multiplier: 1.0, constant: CGFloat(-self.title.bottom))
            self.titleBottomConstraint?.active = true
            
            //Leading
            self.titleLeadingConstraint = NSLayoutConstraint.init(item: _titleLabelControl, attribute: .Leading, relatedBy: .Equal, toItem: self.titlePanel, attribute: .Leading, multiplier: 1.0, constant: CGFloat(self.title.leading))
            self.titleLeadingConstraint?.active = true
            
            //Trailing
            self.titleTrailingConstraint = NSLayoutConstraint.init(item: _titleLabelControl, attribute: .Trailing, relatedBy: .Equal, toItem: self.titlePanel, attribute: .Trailing, multiplier: 1.0, constant: CGFloat(-self.title.trailing))
            self.titleTrailingConstraint?.active = true
        }
    }
    private var titleLabelControl:UILabel{
        get{
            if(_titleLabelControl == nil){
                _titleLabelControl = UILabel()
                
                self.title.font = self.title.font
                self.title.textColor = self.title.textColor
                self.title.textAlignment = self.title.textAlignment
                self.title.text = self.title.text
                
                self.titleSeperator
            }
            
            return _titleLabelControl
        }
    }
    var titleTopConstraint: NSLayoutConstraint?
    var titleBottomConstraint: NSLayoutConstraint?
    var titleTrailingConstraint: NSLayoutConstraint?
    var titleLeadingConstraint: NSLayoutConstraint?
    
    //MARK:标题分割线
    private var _titleSeperator:UIView!{
        didSet{
            //填充色
            _titleSeperator.backgroundColor = self.title.separator.fillColor
            _titleSeperator.tag = 1314
            _titleSeperator.hidden = true
            
            self.titlePanel.addSubview(_titleSeperator)
            _titleSeperator.translatesAutoresizingMaskIntoConstraints = false
            
            //Bottom
            self.titleSeperatorBottomConstraint = NSLayoutConstraint.init(item: _titleSeperator, attribute: .Bottom, relatedBy: .Equal, toItem: self.titlePanel, attribute: .Bottom, multiplier: 1.0, constant: 0)
            self.titleSeperatorBottomConstraint!.active = true
            
            //Leading
            self.titleSeperatorLeadingConstraint = NSLayoutConstraint.init(item: _titleSeperator, attribute: .Leading, relatedBy: .Equal, toItem: self.titlePanel, attribute: .Leading, multiplier: 1.0, constant: CGFloat(self.title.separator.leading))
            self.titleSeperatorLeadingConstraint!.active = true
            
            //Trailing
            self.titleSeperatorTrailingConstraint = NSLayoutConstraint.init(item: _titleSeperator, attribute: .Trailing, relatedBy: .Equal, toItem: self.titlePanel, attribute: .Trailing, multiplier: 1.0, constant: CGFloat(-self.title.separator.trailing))
            self.titleSeperatorTrailingConstraint!.active = true
            
            //高度
            let heightLC = NSLayoutConstraint.init(item: _titleSeperator, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0.5)
            heightLC.active = true
        }
    }
    private var titleSeperator:UIView!{
        get{
            if(_titleSeperator == nil){
                _titleSeperator = UIView()
                
                self.title.separator.fillColor = self.title.separator.fillColor
                self.title.separator.enable = self.title.separator.enable
            }
            
            return _titleSeperator
        }
    }
    var titleSeperatorTopConstraint: NSLayoutConstraint?
    var titleSeperatorBottomConstraint: NSLayoutConstraint?
    var titleSeperatorTrailingConstraint: NSLayoutConstraint?
    var titleSeperatorLeadingConstraint: NSLayoutConstraint?
    
    //MARK: 更新标题分割线（主要是根据有木有“TopMessage、TextField、BottomMessage”来确定是否显示标题分割线）
    private func updateTitleSeparator(){
        if((self.messages.topMessage.text != nil && self.messages.topMessage.text != "") ||
            self.textField.enable ||
            (self.messages.bottomMessage.text != nil && self.messages.bottomMessage.text != "")){
            
            self.title.separator.enable = true
        }
        else{
            self.title.separator.enable = false
        }
    }
    
    //MARK: - TopMessage
    
    private var _topMessagePanel:UIView?{
        didSet{
            //背景色
            _topMessagePanel!.backgroundColor = UIColor.clearColor()
            
            //超过边界不可见
            _topMessagePanel?.clipsToBounds = true
            
            self.addSubview(_topMessagePanel!)
            _topMessagePanel!.translatesAutoresizingMaskIntoConstraints = false
            
            //Top
            let topCS = NSLayoutConstraint.init(item: _topMessagePanel!, attribute: .Top, relatedBy: .Equal, toItem: self.titlePanel, attribute: .Bottom, multiplier: 1.0, constant: 0)
            topCS.active = true
            
            //Leading
            let leadingCS = NSLayoutConstraint.init(item: _topMessagePanel!, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0)
            leadingCS.active = true
            
            //Trailing
            let trailingCS = NSLayoutConstraint.init(item: _topMessagePanel!, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0)
            trailingCS.active = true
        }
    }
    private var topMessagePanel:UIView{
        get{
            if(_topMessagePanel == nil){
                _topMessagePanel = UIView()
            }
            
            return _topMessagePanel!
        }
    }
    
    private var _topMessageLabelControl: UILabel!{
        didSet{
            //背景色
            _topMessageLabelControl.backgroundColor = UIColor.clearColor()
            
            //不限定行数
            _topMessageLabelControl.numberOfLines = 0
            
            self.topMessagePanel.addSubview(_topMessageLabelControl)
            _topMessageLabelControl.translatesAutoresizingMaskIntoConstraints = false
            
            //Top
            self.topMessageTopConstraint = NSLayoutConstraint.init(item: _topMessageLabelControl, attribute: .Top, relatedBy: .Equal, toItem: self.topMessagePanel, attribute: .Top, multiplier: 1.0, constant: CGFloat(self.messages.topMessage.top))
            self.topMessageTopConstraint?.active = true
            
            //Bottom
            self.topMessageBottomConstraint = NSLayoutConstraint.init(item: _topMessageLabelControl, attribute: .Bottom, relatedBy: .Equal, toItem: self.topMessagePanel, attribute: .Bottom, multiplier: 1.0, constant: CGFloat(-self.messages.topMessage.bottom))
            self.topMessageBottomConstraint?.active = true
            
            //Leading
            self.topMessageLeadingConstraint = NSLayoutConstraint.init(item: _topMessageLabelControl, attribute: .Leading, relatedBy: .Equal, toItem: self.topMessagePanel, attribute: .Leading, multiplier: 1.0, constant: CGFloat(self.messages.topMessage.leading))
            self.topMessageLeadingConstraint?.active = true
            
            //Trailing
            self.topMessageTrailingConstraint = NSLayoutConstraint.init(item: _topMessageLabelControl, attribute: .Trailing, relatedBy: .Equal, toItem: self.topMessagePanel, attribute: .Trailing, multiplier: 1.0, constant: CGFloat(-self.messages.topMessage.trailing))
            self.topMessageTrailingConstraint?.active = true
        }
    }
    private var topMessageLabelControl: UILabel{
        get{
            if(_topMessageLabelControl == nil){
                _topMessageLabelControl = UILabel()
                
                self.messages.topMessage.font = self.messages.topMessage.font
                self.messages.topMessage.textColor = self.messages.topMessage.textColor
                self.messages.topMessage.textAlignment = self.messages.topMessage.textAlignment
                self.messages.topMessage.text = self.messages.topMessage.text
            }
            
            return _topMessageLabelControl
        }
    }
    private var topMessageTopConstraint:NSLayoutConstraint?
    private var topMessageBottomConstraint:NSLayoutConstraint?
    private var topMessageLeadingConstraint:NSLayoutConstraint?
    private var topMessageTrailingConstraint:NSLayoutConstraint?
    
    
    //MARK: - TextField
    
    private var _textFieldPanel:UIView?{
        didSet{
            //背景色
            _textFieldPanel!.backgroundColor = UIColor.clearColor()
            
            //超过边界不可见
            _textFieldPanel?.clipsToBounds = true
            
            self.addSubview(_textFieldPanel!)
            _textFieldPanel!.translatesAutoresizingMaskIntoConstraints = false
            
            //Top
            let topCS = NSLayoutConstraint.init(item: _textFieldPanel!, attribute: .Top, relatedBy: .Equal, toItem: self.topMessagePanel, attribute: .Bottom, multiplier: 1.0, constant: 0)
            topCS.active = true
            
            //Leading
            let leadingCS = NSLayoutConstraint.init(item: _textFieldPanel!, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0)
            leadingCS.active = true
            
            //Trailing
            let trailingCS = NSLayoutConstraint.init(item: _textFieldPanel!, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0)
            trailingCS.active = true
            
            //高度
            self.textFieldHeightConstraint = NSLayoutConstraint.init(item: _textFieldPanel!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: self.textField.enable ? 38.0 : 0.0)
            self.textFieldHeightConstraint?.active = true
        }
    }
    private var textFieldPanel:UIView{
        get{
            if(_textFieldPanel == nil){
                _textFieldPanel = UIView()
            }
            
            return _textFieldPanel!
        }
    }
    
    private var _textFieldControl: UITextField?{
        didSet{
            self.textFieldPanel.addSubview(_textFieldControl!)
            _textFieldControl!.translatesAutoresizingMaskIntoConstraints = false

            //Top
            self.textFieldTopConstraint = NSLayoutConstraint.init(item: _textFieldControl!, attribute: .Top, relatedBy: .Equal, toItem: self.textFieldPanel, attribute: .Top, multiplier: 1.0, constant: CGFloat(self.textField.top))
            self.textFieldTopConstraint?.active = true
            
            //Bottom
            self.textFieldBottomConstraint = NSLayoutConstraint.init(item: _textFieldControl!, attribute: .Bottom, relatedBy: .Equal, toItem: self.textFieldPanel, attribute: .Bottom, multiplier: 1.0, constant: CGFloat(-self.textField.bottom))
            self.textFieldBottomConstraint?.active = true

            //Leading
            self.textFieldLeadingConstraint = NSLayoutConstraint.init(item: _textFieldControl!, attribute: .Leading, relatedBy: .Equal, toItem: self.textFieldPanel, attribute: .Leading, multiplier: 1.0, constant: CGFloat(self.textField.leading))
            self.textFieldLeadingConstraint?.active = true

            //Trailing
            self.textFieldTrailingConstraint = NSLayoutConstraint.init(item: _textFieldControl!, attribute: .Trailing, relatedBy: .Equal, toItem: self.textFieldPanel, attribute: .Trailing, multiplier: 1.0, constant: CGFloat(-self.textField.trailing))
            self.textFieldTrailingConstraint?.active = true
            

            
//            print(self.textFieldHeightConstraint)
        }
    }
    private var textFieldControl: UITextField{
        get{
            if(_textFieldControl == nil){
                _textFieldControl = UITextField()
                
                self.textField.text = self.textField.text
                self.textField.textColor = self.textField.textColor
                self.textField.textAlignment = self.textField.textAlignment
                self.textField.font = self.textField.font
                self.textField.placeholder = self.textField.placeholder
                self.textField.borderStyle = self.textField.borderStyle
                self.textField.enable = self.textField.enable
            }
            
            return _textFieldControl!
        }
    }
    private var textFieldTopConstraint:NSLayoutConstraint?
    private var textFieldBottomConstraint:NSLayoutConstraint?
    private var textFieldLeadingConstraint:NSLayoutConstraint?
    private var textFieldTrailingConstraint:NSLayoutConstraint?
    private var textFieldHeightConstraint:NSLayoutConstraint?
    
    //MARK: - BottomMessage
    
    private var _bottomMessagePanel:UIView?{
        didSet{
            //背景色
            _bottomMessagePanel!.backgroundColor = UIColor.clearColor()
            
            //超过边界不可见
            _bottomMessagePanel?.clipsToBounds = true
            
            self.addSubview(_bottomMessagePanel!)
            _bottomMessagePanel!.translatesAutoresizingMaskIntoConstraints = false
            
            //Top
            let topCS = NSLayoutConstraint.init(item: _bottomMessagePanel!, attribute: .Top, relatedBy: .Equal, toItem: self.textFieldPanel, attribute: .Bottom, multiplier: 1.0, constant: 0)
            topCS.active = true
            
            //Leading
            let leadingCS = NSLayoutConstraint.init(item: _bottomMessagePanel!, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0)
            leadingCS.active = true
            
            //Trailing
            let trailingCS = NSLayoutConstraint.init(item: _bottomMessagePanel!, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0)
            trailingCS.active = true
        }
    }
    private var bottomMessagePanel:UIView{
        get{
            if(_bottomMessagePanel == nil){
                _bottomMessagePanel = UIView()
            }
            
            return _bottomMessagePanel!
        }
    }
    
    private var _bottomMessageLabelControl: UILabel!{
        didSet{
            //背景色
            _bottomMessageLabelControl.backgroundColor = UIColor.clearColor()
            
            //不限定行数
            _bottomMessageLabelControl.numberOfLines = 0
            
            self.bottomMessagePanel.addSubview(_bottomMessageLabelControl)
            _bottomMessageLabelControl.translatesAutoresizingMaskIntoConstraints = false
            
            //Top
            self.bottomMessageTopConstraint = NSLayoutConstraint.init(item: _bottomMessageLabelControl, attribute: .Top, relatedBy: .Equal, toItem: self.bottomMessagePanel, attribute: .Top, multiplier: 1.0, constant: CGFloat(self.messages.bottomMessage.top))
            self.bottomMessageTopConstraint?.active = true
            
            //Bottom
            self.bottomMessageBottomConstraint = NSLayoutConstraint.init(item: _bottomMessageLabelControl, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomMessagePanel, attribute: .Bottom, multiplier: 1.0, constant: CGFloat(-self.messages.bottomMessage.bottom))
            self.bottomMessageBottomConstraint?.active = true
            
            //Leading
            self.bottomMessageLeadingConstraint = NSLayoutConstraint.init(item: _bottomMessageLabelControl, attribute: .Leading, relatedBy: .Equal, toItem: self.bottomMessagePanel, attribute: .Leading, multiplier: 1.0, constant: CGFloat(self.messages.bottomMessage.leading))
            self.bottomMessageLeadingConstraint?.active = true
            
            //Trailing
            self.bottomMessageTrailingConstraint = NSLayoutConstraint.init(item: _bottomMessageLabelControl, attribute: .Trailing, relatedBy: .Equal, toItem: self.bottomMessagePanel, attribute: .Trailing, multiplier: 1.0, constant: CGFloat(-self.messages.bottomMessage.trailing))
            self.bottomMessageTrailingConstraint?.active = true
        }
    }
    
    private var bottomMessageLabelControl: UILabel{
        get{
            if(_bottomMessageLabelControl == nil){
                _bottomMessageLabelControl = UILabel()
                
                self.messages.bottomMessage.font = self.messages.bottomMessage.font
                self.messages.bottomMessage.textColor = self.messages.bottomMessage.textColor
                self.messages.bottomMessage.textAlignment = self.messages.bottomMessage.textAlignment
                self.messages.bottomMessage.text = self.messages.bottomMessage.text
            }
            
            return _bottomMessageLabelControl
        }
    }
    private var bottomMessageTopConstraint:NSLayoutConstraint?
    private var bottomMessageBottomConstraint:NSLayoutConstraint?
    private var bottomMessageLeadingConstraint:NSLayoutConstraint?
    private var bottomMessageTrailingConstraint:NSLayoutConstraint?
    
//    //MARK: - 不再提醒
//    private var _noLongerRemindPanel: UIView!{
//        didSet{
//            self.addSubview(_noLongerRemindPanel)
//            _noLongerRemindPanel.translatesAutoresizingMaskIntoConstraints = false
//            
//            //Top
//            self.noLongerRemindPanelTopConstraint = NSLayoutConstraint.init(item: _noLongerRemindPanel, attribute: .Top, relatedBy: .Equal, toItem: self.bottomMessageLabelControl, attribute: .Bottom, multiplier: 1.0, constant: self.textField.enable ? 8.0 : 0.0)
//            self.noLongerRemindPanelTopConstraint?.active = true
//            
//            //Leading
//            let leadigLC = NSLayoutConstraint.init(item: _noLongerRemindPanel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 8.0)
//            leadigLC.active = true
//            
//            //Trailing
//            let trailingLC = NSLayoutConstraint.init(item: _noLongerRemindPanel, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -8.0)
//            trailingLC.active = true
//        }
//    }
//    private var noLongerRemindPanel: UIView{
//        get{
//            if(_noLongerRemindPanel == nil){
//                _noLongerRemindPanel = UIView()
//            }
//            
//            return _noLongerRemindPanel
//        }
//    }
//    private var noLongerRemindPanelTopConstraint:NSLayoutConstraint?//Bottom信息Top约束
    
    //MARK: - 底部按钮
    
    //底部按钮容器(请勿直接调用，可调用buttonPanel)
    private var _buttonPanel: UIView!{
        didSet{
            _buttonPanel.clipsToBounds = true
            
            self.addSubview(_buttonPanel)
            _buttonPanel.translatesAutoresizingMaskIntoConstraints = false
            
            //Leading
            let leadigLC = NSLayoutConstraint.init(item: _buttonPanel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0)
            leadigLC.active = true
            
            //Trailing
            let trailingLC = NSLayoutConstraint.init(item: _buttonPanel, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0)
            trailingLC.active = true
            
            //Top
            self.buttonPanelTopConstraint = NSLayoutConstraint.init(item: _buttonPanel, attribute: .Top, relatedBy: .Equal, toItem: self.bottomMessagePanel, attribute: .Bottom, multiplier: 1.0, constant: 0)
            self.buttonPanelTopConstraint?.active = true;
            
            //Bottom
            let bottomLC = NSLayoutConstraint.init(item: _buttonPanel, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0)
            bottomLC.active = true
            
            //高度
            self.buttonPanelHeightConstraint = NSLayoutConstraint.init(item: _buttonPanel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 44.0)
            self.buttonPanelHeightConstraint?.active = true
            
            //水平分割线
            self.buttonHorizontalSeparator
            
            //垂直分割线
            self.buttonVerticalSeparator
        }
    }
    private var buttonPanel:UIView{//底部按钮容器
        get{
            if(_buttonPanel == nil){
                _buttonPanel = UIView()
            }
            
            return _buttonPanel
        }
    }
    private var buttonPanelHeightConstraint: NSLayoutConstraint?//按钮容器的高度
    private var buttonPanelTopConstraint: NSLayoutConstraint?//按钮容器的Top约束
    
    ///按钮水平分割线
    private var _buttonHorizontalSeparator:UIView!{
        didSet{
            //填充色
            _buttonHorizontalSeparator.backgroundColor = UIColor(red: 234 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, alpha: 1.0)
            _buttonHorizontalSeparator.tag = 1314
            
            self.buttonPanel.addSubview(_buttonHorizontalSeparator)
            _buttonHorizontalSeparator.translatesAutoresizingMaskIntoConstraints = false
            
            //Top
            let topLC = NSLayoutConstraint.init(item: _buttonHorizontalSeparator, attribute: .Top, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Top, multiplier: 1.0, constant: 0.0)
            topLC.active = true
            
            //Leading
            let leadigLC = NSLayoutConstraint.init(item: _buttonHorizontalSeparator, attribute: .Leading, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Leading, multiplier: 1.0, constant: 4.0)
            leadigLC.active = true
            
            //Trailing
            let trailingLC = NSLayoutConstraint.init(item: _buttonHorizontalSeparator, attribute: .Trailing, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Trailing, multiplier: 1.0, constant: -4.0)
            trailingLC.active = true
            
            //高度
            let heightLC = NSLayoutConstraint.init(item: _buttonHorizontalSeparator, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0.5)
            heightLC.active = true
        }
    }
    private var buttonHorizontalSeparator:UIView!{
        get{
            if(_buttonHorizontalSeparator == nil){
                _buttonHorizontalSeparator = UIView()
            }
            
            return _buttonHorizontalSeparator
        }
    }
    
    ///按钮水平分割线
    private var _buttonVerticalSeparator:UIView!{
        didSet{
            //填充色
            _buttonVerticalSeparator.backgroundColor = UIColor(red: 234 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, alpha: 1.0)
            _buttonVerticalSeparator.tag = 1315
            
            self.buttonPanel.addSubview(_buttonVerticalSeparator)
            _buttonVerticalSeparator.translatesAutoresizingMaskIntoConstraints = false

            //CenterX
            let centerXLC = NSLayoutConstraint.init(item: _buttonVerticalSeparator, attribute: .CenterX, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
            centerXLC.active = true
            
            //CenterY
            let centerYLC = NSLayoutConstraint.init(item: _buttonVerticalSeparator, attribute: .CenterY, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
            centerYLC.active = true
            
            //宽度
            let widthLC = NSLayoutConstraint.init(item: _buttonVerticalSeparator, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0.5)
            widthLC.active = true
            
            //高度
            let heightLC = NSLayoutConstraint.init(item: _buttonVerticalSeparator, attribute: .Height, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Height, multiplier: 0.67, constant: 0)
            heightLC.active = true
        }
    }
    private var buttonVerticalSeparator:UIView!{
        get{
            if(_buttonVerticalSeparator == nil){
                _buttonVerticalSeparator = UIView()
            }
            
            return _buttonVerticalSeparator
        }
    }
    
    
    //MARK: 左边的按钮(请勿直接调用，可调用leftButtonControl)
    private var _leftButtonControl: UIButton!{
        didSet{
            //背景色
            self._leftButtonControl.backgroundColor = UIColor.clearColor()
            
            self.buttonPanel.addSubview(_leftButtonControl)
            _leftButtonControl.translatesAutoresizingMaskIntoConstraints = false
            
            //点击事件
            _leftButtonControl.addTarget(self, action: #selector(self.leftButtonClick(_:)), forControlEvents: .TouchUpInside)
            
            //Top
            let topLC = NSLayoutConstraint.init(item: _leftButtonControl, attribute: .Top, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Top, multiplier: 1.0, constant: 0)
            topLC.active = true
            
            //Leading
            let leadigLC = NSLayoutConstraint.init(item: _leftButtonControl, attribute: .Leading, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Leading, multiplier: 1.0, constant: 0)
            leadigLC.active = true
            
            //Bottom
            let bottomLC = NSLayoutConstraint.init(item: _leftButtonControl, attribute: .Bottom, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Bottom, multiplier: 1.0, constant: 0)
            bottomLC.active = true
            
            //== 父容器宽度的一半
            self.leftButtonWidthConstraint_PanelHalfWidth = NSLayoutConstraint.init(item: _leftButtonControl, attribute: .Width, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Width, multiplier: 0.5, constant: 0)
            self.leftButtonWidthConstraint_PanelHalfWidth!.active = true
            
            //== 父容器的宽度
            self.leftButtonWidthConstraint_PanelWidth = NSLayoutConstraint.init(item: _leftButtonControl, attribute: .Width, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Width, multiplier: 1.0, constant: 0)
           
            self.leftButtonWidthConstraint_PanelWidth!.active = false
        }
    }
    private var leftButtonControl: UIButton{
        get{
            if(_leftButtonControl == nil){
                _leftButtonControl = UIButton()
                
                self.buttons.leftButton.enable = self.buttons.leftButton.enable
                self.buttons.leftButton.title = self.buttons.leftButton.title
                self.buttons.leftButton.titleColor = self.buttons.leftButton.titleColor
                self.buttons.leftButton.font = self.buttons.leftButton.font
            }
            
            return _leftButtonControl
        }
    }
    
    private var leftButtonWidthConstraint_PanelHalfWidth: NSLayoutConstraint!//左边的按钮的宽度 == 父容器的宽度的一半
    private var leftButtonWidthConstraint_PanelWidth: NSLayoutConstraint!//左边的按钮的宽度 == 父容器的宽度

    var leftButtonClicked: buttonClick?
    @objc private func leftButtonClick(sender: UIButton){
        if (self.leftButtonClicked != nil){
            self.leftButtonClicked!(textValue: self.textFieldControl.text ?? "")
        }
        else{
            self .hideFromSuperView()
        }
    }
    
    
    //MARK: 右边的按钮(请勿直接调用，可调用leftButtonControl)
    private var _rightButtonControl: UIButton!{
        didSet{
            self.buttonPanel.addSubview(_rightButtonControl)
            _rightButtonControl.translatesAutoresizingMaskIntoConstraints = false
            
            //点击事件
            _rightButtonControl.addTarget(self, action: #selector(self.rightButtonClick(_:)), forControlEvents: .TouchUpInside)

            
            //Top
            let topLC = NSLayoutConstraint.init(item: _rightButtonControl, attribute: .Top, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Top, multiplier: 1.0, constant: 0)
            topLC.active = true
            
            //Bottom
            let bottomLC = NSLayoutConstraint.init(item: _rightButtonControl, attribute: .Bottom, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Bottom, multiplier: 1.0, constant: 0)
            bottomLC.active = true
            
            //Trailing
            let leadigLC = NSLayoutConstraint.init(item: _rightButtonControl, attribute: .Trailing, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Trailing, multiplier: 1.0, constant: 0)
            leadigLC.active = true
            
            //== 父容器宽度的一半
            self.rightButtonWidthConstraint_PanelHalfWidth = NSLayoutConstraint.init(item: self._rightButtonControl, attribute: .Width, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Width, multiplier: 0.5, constant: 0)
            self.rightButtonWidthConstraint_PanelHalfWidth!.active = true
            
            //== 父容器的宽度
            self.rightButtonWidthConstraint_PanelWidth = NSLayoutConstraint.init(item: self._rightButtonControl, attribute: .Width, relatedBy: .Equal, toItem: self.buttonPanel, attribute: .Width, multiplier: 1.0, constant: 0)
            
            self.rightButtonWidthConstraint_PanelWidth!.active = false
        }
    }
    private var rightButtonControl: UIButton{
        get{
            if(_rightButtonControl == nil){
                _rightButtonControl = UIButton()
                
                self.buttons.rightButton.enable = self.buttons.rightButton.enable
                self.buttons.rightButton.title = self.buttons.rightButton.title
                self.buttons.rightButton.titleColor = self.buttons.rightButton.titleColor
                self.buttons.rightButton.font = self.buttons.rightButton.font
            }
            
            return _rightButtonControl
        }
    }
    
    private var rightButtonWidthConstraint_PanelHalfWidth: NSLayoutConstraint!//右边的按钮的宽度 == 父容器的宽度的一半
    private var rightButtonWidthConstraint_PanelWidth: NSLayoutConstraint!//右边的按钮的宽度 == 父容器的宽度
    
    var rightButtonClicked: buttonClick?
    @objc private func rightButtonClick(sender: UIButton){
        if (self.rightButtonClicked != nil){
            self.rightButtonClicked!(textValue: self.textFieldControl.text ?? "")
        }
        else{
            self .hideFromSuperView()
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}