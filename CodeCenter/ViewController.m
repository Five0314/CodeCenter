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
    MessageViewSwift * newUV = [MessageViewSwift new];
    __weak MessageViewSwift * weakUV = newUV;
    newUV.title.text = @"百撕不得骑姐";
    newUV.title.textColor = [UIColor purpleColor];
    newUV.title.font = [UIFont systemFontOfSize:20.0];
    newUV.title.top = 10.0;
    newUV.title.bottom = 50.0;
    
    newUV.topMessage.text = @"无敌提示";
    newUV.topMessage.textColor = [UIColor cyanColor];
    newUV.topMessage.top = 10.0;
    newUV.topMessage.bottom = 50.0;
    
    newUV.textField.placeholder = @"我们一起看月亮爬上来";
    newUV.textField.enable = true;
    newUV.textField.top = 10.0;
    newUV.textField.bottom = 50.0;
    
    newUV.bottomMessage.text = @"你大爷打野";
    newUV.bottomMessage.textColor = [UIColor orangeColor];
    newUV.bottomMessage.top = 10.0;
    newUV.bottomMessage.bottom = 50.0;
//    newUV.bottomMessage.leading = 100;
//    newUV.bottomMessage.trailing = 100;

    
    newUV.leftButton.title = @"河蟹";
    newUV.leftButton.titleColor = [UIColor blueColor];
//    newUV.leftButton.enable = false;
    
//    newUV.rightButton.enable = false;
    newUV.rightButton.title = @"草泥马";
    newUV.rightButton.titleColor = [UIColor redColor];
    


    
    newUV.leftButtonClicked = ^(NSString * textValue) {
        [weakUV hideFromSuperView];
    };
    
    newUV.rightButtonClicked = ^(NSString * textValue) {
        weakUV.topMessage.text = @"哎哟，你点击草泥马";
        weakUV.bottomMessage.text = @"草泥马吐了你一脸口水";
        weakUV.textField.placeholder = @"来打我啊，咩 ~ ~ ~";
    };
    
    [newUV setMaskClick:^{
        weakUV.leftButton.title = @"取消";
        weakUV.leftButton.titleColor = [UIColor lightGrayColor];
        
        weakUV.rightButton.title = @"德玛西亚";
        weakUV.rightButton.titleColor = [UIColor colorWithRed:0 green:122 / 255.0 blue:1 alpha:1.0];
    }];
    
    NSArray * cs = [newUV constraintsOC:self.view centerX:@0 centerY:@0 specifiedWidth:@250 specifiedHeight:nil];
    
    [newUV showInViewOC:self.view showStyle:CNShowOrHideStyleOCRight hideStyle:CNShowOrHideStyleOCRight options:cs maskStyle:CNMaskStyleOCShow | CNMaskStyleOCClickEnable];
    
//    [newUV showFromLeft:self.view constraints:cs showMask:true maskClickEnable:true];
}



@end
