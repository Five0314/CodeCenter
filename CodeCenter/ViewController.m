//
//  ViewController.m
//  CodeCenter
//
//  Created by line on 16/4/24.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "ViewController.h"
#import "CodeCenter-Swift.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(BOOL)shouldAutorotate
//{
//    NSLog(@" ====================================== shouldAutorotate");
//    return YES;
//}
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    NSLog(@" ====================================== supportedInterfaceOrientations");
//    return UIInterfaceOrientationMaskLandscapeRight;
//}
//
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    
//    NSLog(@"preferredInterfaceOrientationForPresentation");
//    return UIInterfaceOrientationLandscapeRight;
//}

// MARK: - MessageView
- (IBAction)click:(UIButton *)sender{
    MessageView * newUV = [MessageView new];
    newUV.layer.shadowColor = [UIColor blackColor].CGColor;
    newUV.layer.shadowOpacity = 0.5;
    newUV.layer.shadowRadius = 5;
    newUV.layer.shadowOffset = CGSizeMake(0, 0);
    
    __weak MessageView * weakUV = newUV;
    
    newUV.title.text = @"标题“我就是标题”";
    newUV.messages.topMessage.text = @"陷阵之至，当有死无生。“啦啦啦啦啦”";
    newUV.messages.bottomMessage.text = @"陷阵之至，当有死无生。“啦啦啦啦啦”";

    newUV.buttons.leftButton.click = ^(NSString * textValue) {
        [weakUV hideFromSuperView];
    };
    
    newUV.buttons.rightButton.click = ^(NSString * textValue) {
        weakUV.messages.topMessage.text = @"哎哟，你点击草泥马，123";
        weakUV.messages.topMessage.regularExpression = @"[\u4e00-\u9fa50-9]+";//高亮汉字、数字essages.bottomMessage.text = @"草泥马吐了你一脸口水";
        weakUV.messages.bottomMessage.regularExpression = [NSString cnRegularWithSpecifiedString:@"草泥马"];
        weakUV.textField.placeholder = @"来打我啊，咩 ~ ~ ~";
        
        weakUV.messages.topMessage.separator.enable = true;
    };
    
    [newUV setMaskClick:^{
        weakUV.buttons.leftButton.title = @"雅蠛蝶";
        weakUV.buttons.leftButton.titleColor = [UIColor brownColor];
        
        weakUV.buttons.rightButton.title = @"德玛西亚";
        weakUV.buttons.rightButton.titleColor = [UIColor redColor];
    }];
    
    AppDelegate * apd = [UIApplication sharedApplication].delegate;
    NSArray * cs = [newUV constraintsOC:apd.window centerX:@0 centerY:@(-25) specifiedWidth:@250 specifiedHeight:nil];
    
    [newUV showInViewOC:apd.window showStyle:CNShowOrHideStyleOCRight hideStyle:CNShowOrHideStyleOCRight options:cs maskStyle:CNMaskStyleOCClickEnable];
}

// MARK: - Chart
- (IBAction)chart:(UIButton *)sender{
    
}

@end
