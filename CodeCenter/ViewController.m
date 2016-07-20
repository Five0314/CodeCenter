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
#import "RMJTeamInformation.h"
#import "CNCoderCenter.h"

@interface ViewController ()

@property(weak, nonatomic) IBOutlet UIView * topView;
@property(weak, nonatomic) IBOutlet UIImageView * topImageView;

@property(weak, nonatomic) IBOutlet UIView * leftView;
@property(weak, nonatomic) IBOutlet UIImageView * leftImageView;

@property(weak, nonatomic) IBOutlet UIView * rightView;
@property(weak, nonatomic) IBOutlet UIImageView * rightImageView;
//@property(weak, nonatomic) IBOutlet UIView * rightView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topView.layer.borderColor = [UIColor whiteColor].CGColor;
    _topView.layer.borderWidth = 2;
    
    _topImageView.layer.cornerRadius = _topImageView.bounds.size.width / 2;
    _topImageView.layer.masksToBounds = true;
    _topImageView.image = [UIImage imageNamed:@"1.jpg"];
//    http://img3.duitang.com/uploads/item/201412/31/20141231080254_2zvEH.thumb.700_0.jpeg
    
    _leftView.layer.borderColor = [UIColor whiteColor].CGColor;
    _leftView.layer.borderWidth = 2;
    
    _leftImageView.layer.cornerRadius = _leftImageView.bounds.size.width / 2;
    _leftImageView.layer.masksToBounds = true;
    _leftImageView.image = [UIImage imageNamed:@"2.jpg"];
    
    _rightView.layer.borderColor = [UIColor whiteColor].CGColor;
    _rightView.layer.borderWidth = 2;
    
    _rightImageView.layer.cornerRadius = _rightImageView.bounds.size.width / 2;
    _rightImageView.layer.masksToBounds = true;
    _rightImageView.image = [UIImage imageNamed:@"3.jpg"];

    CGFloat radius = _leftView.bounds.size.width * 0.5;
    
    CGFloat angle = acosf((_leftView.superview.bounds.size.width - _leftView.bounds.size.width) * 0.5 / radius);
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(radius, sqrtf(pow(radius, 2) - pow(_leftView.superview.bounds.size.width * 0.5 - radius, 2)))];
    [path addArcWithCenter:CGPointMake((_leftView.superview.bounds.size.width - radius), radius) radius:radius startAngle:M_PI + angle endAngle:M_PI - angle clockwise:false];
    [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:angle endAngle:-angle clockwise:true];
    [path closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    
    [_leftView.layer setMask:shapeLayer];
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
    CNMessageView * newUV = [CNMessageView new];
    newUV.layer.shadowColor = [UIColor blackColor].CGColor;
    newUV.layer.shadowOpacity = 0.5;
    newUV.layer.shadowRadius = 5;
    newUV.layer.shadowOffset = CGSizeMake(0, 0);
    
    __weak CNMessageView * weakUV = newUV;
    
    newUV.title.text = @"标题“我就是标题”";
    weakUV.title.regularExpression = [NSString cnRegularWithSpecifiedString:@"我就是标题"];
    
    newUV.messages.topMessage.text = @"您兑换“小米手环”需支付5000时间豆\n您现拥有4000时间豆\n是否购买1000时间豆?";
    newUV.messages.bottomMessage.text = @"陷阵之至，当有死无生。“啦啦啦啦啦”";
    
    
    weakUV.messages.topMessage.regularExpression = @"\\d|时间豆";

    weakUV.title.separator.bottomSeparator.hidden = false;
    weakUV.messages.topMessage.separator.bottomSeparator.hidden = false;
    
    newUV.buttons.leftButton.click = ^(NSString * textValue) {
        [weakUV hideFromSuperView];
    };
    
    newUV.buttons.rightButton.click = ^(NSString * textValue) {
        weakUV.messages.topMessage.text = @"哎哟，你点击草泥马，123";
        weakUV.messages.topMessage.regularExpression = @"[\u4e00-\u9fa50-9]+";//高亮汉字、数字
        weakUV.messages.bottomMessage.text = @"草泥马吐了你一脸口水";
        weakUV.messages.bottomMessage.regularExpression = [NSString cnRegularWithSpecifiedString:@"草泥马"];
        weakUV.textField.placeholder = @"来打我啊，咩 ~ ~ ~";
        weakUV.textField.enable = true;

    };
    
    [newUV setMaskClick:^{
        weakUV.buttons.leftButton.title = @"雅蠛蝶";
        weakUV.buttons.leftButton.titleColor = [UIColor brownColor];
        
        weakUV.buttons.rightButton.title = @"德玛西亚";
        weakUV.buttons.rightButton.titleColor = [UIColor redColor];
    }];
    
    AppDelegate * apd = [UIApplication sharedApplication].delegate;
    NSArray * cs = [newUV constraintsOC:apd.window centerX:@0 centerY:@(-25) specifiedWidth:@290 specifiedHeight:nil];
    
    [newUV showInViewOC:apd.window showStyle:CNShowOrHideStyleOCRight hideStyle:CNShowOrHideStyleOCRight options:cs maskStyle:CNMaskStyleOCClickEnable];
}

// MARK: - Chart
- (IBAction)chart:(UIButton *)sender{
    
}

// MARK: - 左对齐
- (IBAction)leftCollectionView:(UIButton *)sender{
    RMJTeamInformation * newUV = [RMJTeamInformation new];
    
    NSArray * cs = [newUV constraintsOC:APPDELEGATE.window relatedWidth:@(0) relatedHeight:@(-250) centerX:@(0) centerY:@(10)];
    [newUV showInViewOC:APPDELEGATE.window showStyle:CNShowOrHideStyleOCLeft hideStyle:CNShowOrHideStyleOCLeft options:cs maskStyle:CNMaskStyleOCClickEnable | CNMaskStyleOCShow];
}

@end
