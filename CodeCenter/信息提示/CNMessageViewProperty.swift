//
//  CNMessageViewProperty.swift
//  CodeCenter
//
//  Created by Five0314 on 16/6/10.
//  Copyright © 2016年 Five. All rights reserved.
//

import UIKit

///属性值变更
typealias propertyChange = @convention(block) (_ propertyName: NSString) -> Void

///按钮点击回调
typealias buttonClick = @convention(block) (_ textValue: NSString) -> Void

//protocol CNKVOPropertyProtocol {
//    var propertyValueChanged: propertyChange?{ get set}
//}

class CNKVOProperty: NSObject {
    var propertyValueChanged: propertyChange?
}

//MARK: - 边距约束
class CNConstraintProperty: CNKVOProperty{
    var top: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("top")
            }
        }
    }
    var bottom: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("bottom")
            }
        }
    }
    var leading: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("leading")
            }
        }
    }
    var trailing: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("trailing")
            }
        }
    }
}

//MARK: - Label
class CNLabelProperty: CNConstraintProperty{
    
    var textAlignment:NSTextAlignment = .center{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("textAlignment")
            }
        }
    }
    var textColor:UIColor?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("textColor")
            }
        }
    }
    var font:UIFont?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("font")
            }
        }
    }
    var text:String?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("text")
            }
        }
    }
    var regularExpression:String?{//正则（高亮匹配到的字符串）
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("regularExpression")
            }
        }
    }
    var highlightColor:UIColor = UIColor(red: 255 / 255.0, green: 68 / 255.0, blue: 0 / 255.0, alpha: 1.0){//高亮的颜色
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("highlightColor")
            }
        }
    }
}

//MARK: - 分割线
class CNBaseSeparatorProperty: CNKVOProperty{
    var leading: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("leading")
            }
        }
    }
    var trailing: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("trailing")
            }
        }
    }
    
    var hidden:Bool = true{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("hidden")
            }
        }
    }
    var height:Float = 0.5{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("height")
            }
        }
    }
    var fillColor: UIColor = UIColor(red: 234 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, alpha: 1.0){
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("fillColor")
            }
        }
    }
}
class CNTopSeparatorProperty:CNBaseSeparatorProperty{
    var top: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("top")
            }
        }
    }
}

class CNBottomSeparatorProperty: CNBaseSeparatorProperty{
    var bottom: Float = 0{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("bottom")
            }
        }
    }
}

class CNSeparator: NSObject{
    ///上方分割线
    let topSeparator:CNTopSeparatorProperty = CNTopSeparatorProperty()
    
    ///下方分割线
    let bottomSeparator:CNBottomSeparatorProperty = CNBottomSeparatorProperty()
}

///消息
class CNMessageLabelWithSeparator: CNLabelProperty{
    ///分割线
    let separator: CNSeparator = CNSeparator()
}

class CNMessageContainsTopAndBottomMessage: NSObject{
    ///上方的消息框
    let topMessage: CNMessageLabelWithSeparator = CNMessageLabelWithSeparator()
    
    ///下方的消息框
    let bottomMessage: CNMessageLabelWithSeparator = CNMessageLabelWithSeparator()
}

///文本输入框
class CNTextFieldProperty: CNLabelProperty{
    var placeholder:String?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("placeholder")
            }
        }
    }
    var borderStyle:UITextBorderStyle?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("borderStyle")
            }
        }
    }
    
    var enable:Bool = false{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("enable")
            }
        }
    }
}

//MARK: - 按钮
class CNButtonProperty: CNKVOProperty{
    var titleColor:UIColor?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("titleColor")
            }
        }
    }
    var font:UIFont?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("font")
            }
        }
    }
    var title:String?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("title")
            }
        }
    }
    var enable:Bool = true{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("enable")
            }
        }
    }
    var click: buttonClick?{
        didSet{
            if self.propertyValueChanged != nil{
                self.propertyValueChanged!("click")
            }
        }
    }
}

class CNMessageViewButton: CNKVOProperty{
    let leftButton: CNButtonProperty = CNButtonProperty()
    
    let rightButton: CNButtonProperty = CNButtonProperty()
}



