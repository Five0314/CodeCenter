//
//  ViewController.m
//  CodeCenter
//
//  Created by line on 16/4/24.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "ViewController.h"
#import "CodeCenter-Swift.h"

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


- (IBAction)click:(UIButton *)sender{
    MessageView * newUV = [MessageView new];
    __weak MessageView * weakUV = newUV;
    newUV.title.text = @"title";
//    newUV.title.textColor = [UIColor purpleColor];
    newUV.title.font = [UIFont systemFontOfSize:20.0];
//    newUV.title.separator.fillColor = [UIColor redColor];
//    newUV.title.top = 10.0;
//    newUV.title.bottom = 10.0;

    newUV.messages.topMessage.text = @"陷阵之至";
////    newUV.messages.topMessage.textColor = [UIColor cyanColor];
    newUV.messages.topMessage.top = 50.0;
////    newUV.messages.topMessage.bottom = 15.0;
//
//    newUV.textField.placeholder = @"当有死无生";
//    newUV.textField.enable = true;
//    newUV.textField.top = 10.0;
//    newUV.textField.bottom = 50.0;
//
//    newUV.messages.bottomMessage.text = @"bottomMessage";
//    newUV.messages.bottomMessage.textColor = [UIColor orangeColor];
//    newUV.messages.bottomMessage.top = 10.0;
    newUV.messages.bottomMessage.bottom = 50.0;
//    newUV.messages.bottomMessage.leading = 100;
//    newUV.messages.bottomMessage.trailing = 100;

    
//    newUV.leftButton.title = @"LeftButton";
//    newUV.leftButton.titleColor = [UIColor blueColor];
////    newUV.leftButton.enable = false;
//    
////    newUV.rightButton.enable = false;
//    newUV.rightButton.title = @"RightButton";
//    newUV.rightButton.titleColor = [UIColor redColor];
    


    
    newUV.leftButtonClicked = ^(NSString * textValue) {
        [weakUV hideFromSuperView];
    };
    
    newUV.rightButtonClicked = ^(NSString * textValue) {
        weakUV.messages.topMessage.text = @"哎哟，你点击草泥马";
        weakUV.messages.bottomMessage.text = @"草泥马吐了你一脸口水";
        weakUV.textField.placeholder = @"来打我啊，咩 ~ ~ ~";
    };
    
    [newUV setMaskClick:^{
        weakUV.buttons.leftButton.title = @"取消";
        weakUV.buttons.leftButton.titleColor = [UIColor lightGrayColor];
        
        weakUV.buttons.rightButton.title = @"德玛西亚";
        weakUV.buttons.rightButton.titleColor = [UIColor colorWithRed:0 green:122 / 255.0 blue:1 alpha:1.0];
    }];
    
    NSArray * cs = [newUV constraintsOC:self.view centerX:@0 centerY:@0 specifiedWidth:@250 specifiedHeight:nil];
    
    [newUV showInViewOC:self.view showStyle:CNShowOrHideStyleOCRight hideStyle:CNShowOrHideStyleOCRight options:cs maskStyle:CNMaskStyleOCShow | CNMaskStyleOCClickEnable];
    
//    [newUV showFromLeft:self.view constraints:cs showMask:true maskClickEnable:true];
}



@end
