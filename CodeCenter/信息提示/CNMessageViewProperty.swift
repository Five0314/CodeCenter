//
//  CNMessageViewProperty.swift
//  CodeCenter
//
//  Created by mac on 16/6/10.
//  Copyright © 2016年 Five. All rights reserved.
//

import UIKit

///属性值变更
typealias propertyChange = @convention(block) (propertyName: NSString) -> Void

///按钮点击回调
typealias buttonClick = @convention(block) (textValue: NSString) -> Void

//protocol CNKVOPropertyProtocol {
//    var propertyValueChanged: propertyChange?{ get set}
//}

protocol CNEnableProtocol {
    var enable: Bool{ get set}
}


class CNKVOProperty: NSObject {
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
    var highlightColor:UIColor = UIColor(red: 255 / 255.0, green: 68 / 255.0, blue: 0 / 255.0, alpha: 1.0){//高亮的颜色
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "highlightColor")
            }
        }
    }
}

/// 拥有分割线的Label(Title、TopMessage、BottomMessage)
class CNMessageViewWithSeparator: CNLabelProperty{
    ///分割线
    let separator: CNSeparatorProperty = CNSeparatorProperty()
}

///按钮
class CNMessageViewMessage: CNKVOProperty{
    ///TopMessage
    let topMessage: CNMessageViewWithSeparator = CNMessageViewWithSeparator()
    
    ///BottomMessage
    let bottomMessage: CNMessageViewWithSeparator = CNMessageViewWithSeparator()
}

//分割线
class CNSeparatorProperty: CNConstraintProperty, CNEnableProtocol{
    var enable:Bool = false{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "enable")
            }
        }
    }
    
    var fillColor: UIColor = UIColor(red: 234 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, alpha: 1.0){
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "fillColor")
            }
        }
    }
}

///文本输入框
class CNTextFieldProperty: CNLabelProperty, CNEnableProtocol{
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
class CNButtonProperty: CNKVOProperty, CNEnableProtocol{
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
    var click: buttonClick?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!(propertyName: "click")
            }
        }
    }
}

///按钮
class CNMessageViewButton: CNKVOProperty{
    let leftButton: CNButtonProperty = CNButtonProperty()
    
    let rightButton: CNButtonProperty = CNButtonProperty()
}