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

@property(weak, nonatomic) IBOutlet UIView * topView;

@property(weak, nonatomic) IBOutlet UIView * leftView;

@property(weak, nonatomic) IBOutlet UIView * rightView;
@property(weak, nonatomic) IBOutlet UIView * rightView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIView * maskView = [[UIView alloc] initWithFrame:_leftView.frame];
    
//    _rightView2.maskView = maskView;
    
    _topView.layer.borderColor = [UIColor whiteColor].CGColor;
    _topView.layer.borderWidth = 2;
    
    _leftView.layer.borderColor = [UIColor whiteColor].CGColor;
    _leftView.layer.borderWidth = 2;
    
    _rightView.layer.borderColor = [UIColor whiteColor].CGColor;
    _rightView.layer.borderWidth = 2;
    
    _rightView2.layer.borderColor = [UIColor whiteColor].CGColor;
    _rightView2.layer.borderWidth = 2;


    UIBezierPath * path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-24, 0, _leftView.bounds.size.width + 2, _leftView.bounds.size.height + 2) cornerRadius:_leftView.bounds.size.width / 2 + 1];
    
    UIBezierPath * path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-12, -24, _leftView.bounds.size.width + 2, _leftView.bounds.size.height + 2) cornerRadius:_leftView.bounds.size.width / 2 + 1];
    [path1 appendPath:path2];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path1 bezierPathByReversingPath].CGPath;
    
    [_rightView2.layer setMask:shapeLayer];
}

//+ (UIBezierPath *)cutCorner:(CGRect)originalFrame length:(CGFloat)length
//{
//    CGRect rect = originalFrame;
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    
//    [bezierPath moveToPoint:CGPointMake(0, length)];
//    [bezierPath addLineToPoint:CGPointMake(length, 0)];
//    [bezierPath addLineToPoint:CGPointMake(rect.size.width - length, 0)];
//    [bezierPath addLineToPoint:CGPointMake(rect.size.width, length)];
//    [bezierPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - length)];
//    [bezierPath addLineToPoint:CGPointMake(rect.size.width - length, rect.size.height)];
//    [bezierPath addLineToPoint:CGPointMake(length, rect.size.height)];
//    [bezierPath addLineToPoint:CGPointMake(0, rect.size.height - length)];
//    [bezierPath closePath];
//    return bezierPath;
//}

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

@end
