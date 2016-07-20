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
    _cnLabel.backgroundColor = [UIColor colorWithRed:(255 / (_idx % 3) + 50) / 255.0 green:125 / 255.0 blue:125 / 255.0 alpha:1];
    
//    NSMutableString * text = [NSMutableString new];
//    for (NSUInteger idx = 0; idx < 10; idx++) {
//        [text appendString:[NSString stringWithFormat:@"%@%ld%@", idx == 0 ? @"" : @"   ", (unsigned long)_idx, idx == 10 ? @"" : @"   "]];
//    }
//    _cnLabel.text = text;
    
//    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:0.3];
}

//- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize{
//    
//    return targetSize;
//}

//- (void)sizeToFit{
//    NSLog(@"%s", __func__);
//}

// Override point.
// Called by the collection view before the instance is returned from the reuse queue.
// Subclassers must call super.
- (void)prepareForReuse{
//    NSLog(@"%s %ld", __func__, (unsigned long)_idx);
}

// Classes that want to support custom layout attributes specific to a given UICollectionViewLayout subclass can apply them here.
// This allows the view to work in conjunction with a layout class that returns a custom subclass of UICollectionViewLayoutAttributes from -layoutAttributesForItem: or the corresponding layoutAttributesForHeader/Footer methods.
// -applyLayoutAttributes: is then called after the view is added to the collection view and just before the view is returned from the reuse queue.
// Note that -applyLayoutAttributes: is only called when attributes change, as defined by -isEqual:.
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
//    NSLog(@"%s %ld", __func__, (unsigned long)_idx);
}

// Override these methods to provide custom UI for specific layouts.
- (void)willTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout{
//    NSLog(@"%s %ld", __func__, (unsigned long)_idx);
}
- (void)didTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout{
//    NSLog(@"%s %ld", __func__, (unsigned long)_idx);
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    
    double os = _cnCollectionView.contentOffset.x;
    double cvHW = _cnCollectionView.bounds.size.width * 0.5;
    CGFloat uCTC = fabs(os + cvHW - layoutAttributes.center.x);//Cell的中心到屏幕中心的距离的绝对值

    _headPortraitImageView.superview.superview.alpha = 1 - uCTC / 272;

    return layoutAttributes;
}

@end
