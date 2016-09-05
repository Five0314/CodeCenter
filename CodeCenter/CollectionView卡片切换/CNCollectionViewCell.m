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
    if (_idx % 3 == 0){
        _cnLabel.backgroundColor = [UIColor redColor];
    }
    else if (_idx % 3 == 1){
        _cnLabel.backgroundColor = [UIColor brownColor];
    }
    else{
        _cnLabel.backgroundColor = [UIColor greenColor];
    }
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    double os = _cnCollectionView.contentOffset.x;
    double cvHW = _cnCollectionView.bounds.size.width * 0.5;
    CGFloat uCTC = fabs(os + cvHW - layoutAttributes.center.x);//Cell的中心到屏幕中心的距离的绝对值

    _headPortraitImageView.superview.superview.alpha = 1 - uCTC / (_cnCollectionView.bounds.size.width * 0.9);

    return layoutAttributes;
}

@end
