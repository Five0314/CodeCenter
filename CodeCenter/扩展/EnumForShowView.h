//
//  EnumForShowView.h
//  CodeCenter
//
//  Created by line on 16/4/24.
//  Copyright © 2016年 Five. All rights reserved.
//

#import <Foundation/Foundation.h>

////屏幕尺寸
//#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
//#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//
////RGB
//#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(1)]
//#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//
////NSLOG
//#ifdef DEBUG
//
//#define Log_0314(...) NSLog(__VA_ARGS__)
//#define Method_0314() NSLog(@"%s", __func__)
//#define Error_0314(error) [NSString stringWithFormat:@"网络异常：%@", error]
//
//#else
//
//#define Log_0314(...)
//#define Method_0314()
//#define Error_0314(error) [NSString stringWithFormat:@"网络异常：%ld %@", error.code, error.localizedDescription]
//
//#endif

#pragma 遮罩层样式
/**遮罩层样式*/
typedef NS_OPTIONS(NSUInteger, CNMaskStyleOC) {
    /**无遮罩层*/
    CNMaskStyleOCNone = 0UL,
    
    /**添加遮罩层*/
    CNMaskStyleOCAdd = 1UL,
    
    /**显示遮罩层*/
    CNMaskStyleOCShow = 1UL << 1,
    
    /**可触发点击事件*/
    CNMaskStyleOCClickEnable = 1UL << 2
};

#pragma mark - 方向
/**方向*/
typedef NS_OPTIONS(NSUInteger, CNShowOrHideStyleOC) {
    /**没有方向和*/
    CNShowOrHideStyleOCNone = 0UL,
    
    /**上*/
    CNShowOrHideStyleOCTop = 1UL,
    
    /**下*/
    CNShowOrHideStyleOCBottom = 2UL,
    
    /**左*/
    CNShowOrHideStyleOCLeft = 3UL,
    
    /**右*/
    CNShowOrHideStyleOCRight = 4UL
};

#pragma mark - 加载进度
typedef NS_ENUM(NSUInteger, CNLoadProgress) {
    /**未加载*/
    CNLoadProgressUnLoad = 0UL,
    
    /**加载中*/
    CNLoadProgressLoading = 1UL,
    
    /**加载完毕*/
    CNLoadProgressCompeleted = 2UL,
    
    /**加载失败*/
    CNLoadProgressFail = 3UL,
};


@interface EnumForShowView : NSObject

@end
