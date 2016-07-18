//
//  CNCollectionViewLeftFlowLayout.m
//  CodeCenter
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "CNCollectionViewLeftFlowLayout.h"

@implementation CNCollectionViewLeftFlowLayout

//- (instancetype)init{
//    self = [super init];
//    if (self){
//        _maximumInteritemSpacing = 0;
//    }
//    return self;
//}
//
//- (void)awakeFromNib{
//    _maximumInteritemSpacing = 0;
//}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    //使用系统帮我们计算好的结果。
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    //第0个cell没有上一个cell
    for(int i = 1; i < [attributes count]; ++i) {
        //根据 maximumInteritemSpacing 计算出的当前Cell的 x 位置
        UICollectionViewLayoutAttributes * preAttr = attributes[i - 1];
        NSInteger origin = CGRectGetMaxX(preAttr.frame);
        CGFloat targetX = origin + super.minimumLineSpacing;
        
        // 只有系统计算的间距大于 maximumInteritemSpacing 时才进行调整
        UICollectionViewLayoutAttributes * curAttr = attributes[i];
        if (CGRectGetMinX(curAttr.frame) > targetX) {
            // 换行时不用调整
            if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) {
                CGRect frame = curAttr.frame;
                frame.origin.x = targetX;
                curAttr.frame = frame;
            }
        }
    }
    
    return attributes;
}

@end
