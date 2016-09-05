//
//  CNCollectionViewCell.m
//  CodeCenter
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "CNCollectionViewCell.h"

@interface CNCollectionViewCell()

@property(weak, nonatomic) IBOutlet UIImageView * headPortraitImageView;

@end

@implementation CNCollectionViewCell

- (void)awakeFromNib{
    _headPortraitImageView.layer.cornerRadius = _headPortraitImageView.bounds.size.width * 0.5;
    _headPortraitImageView.clipsToBounds = true;
    
    _headPortraitImageView.superview.layer.cornerRadius = _headPortraitImageView.superview.bounds.size.width * 0.5;
    _headPortraitImageView.superview.clipsToBounds = true;
    
    _headPortraitImageView.superview.superview.layer.cornerRadius = _headPortraitImageView.superview.superview.bounds.size.width * 0.5;
    _headPortraitImageView.superview.superview.clipsToBounds = true;
}

- (void)reshow{
//    _cnLabel.backgroundColor = [UIColor colorWithRed:(255 / (_idx % 3) + 50) / 255.0 green:125 / 255.0 blue:125 / 255.0 alpha:1];
    if (_idx % 3 == 0){
        _cnLabel.backgroundColor = [UIColor redColor];
    }
    else if (_idx % 3 == 1){
        _cnLabel.backgroundColor = [UIColor brownColor];
    }
    else{
        _cnLabel.backgroundColor = [UIColor greenColor];
    }
    
//    NSMutableString * text = [NSMutableString new];
//    for (NSUInteger idx = 0; idx < 10; idx++) {
//        [text appendString:[NSString stringWithFormat:@"%@%ld%@", idx == 0 ? @"" : @"   ", (unsigned long)_idx, idx == 10 ? @"" : @"   "]];
//    }
//    _cnLabel.text = text;
    
//    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:0.3];
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    double os = _cnCollectionView.contentOffset.x;
    double cvHW = _cnCollectionView.bounds.size.width * 0.5;
    CGFloat uCTC = fabs(os + cvHW - layoutAttributes.center.x);//Cell的中心到屏幕中心的距离的绝对值

    _headPortraitImageView.superview.superview.alpha = 1 - uCTC / (_cnCollectionView.bounds.size.width * 0.9);
//    _headPortraitImageView.superview.superview.alpha = 1 - uCTC / cvHW;

    return layoutAttributes;
}

@end
