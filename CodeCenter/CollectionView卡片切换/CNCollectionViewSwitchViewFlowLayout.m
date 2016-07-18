//
//  CNCollectionViewSwitchViewFlowLayout.m
//  CodeCenter
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "CNCollectionViewSwitchViewFlowLayout.h"

@implementation CNCollectionViewSwitchViewFlowLayout{
//    NSMutableArray * _attributeAttay;
}

//- (void)awakeFromNib{
//    _itemCount = 30;
//}
//
//-(void)prepareLayout{
//    [super prepareLayout];
//    //获取item的个数
//    _itemCount = (int)[self.collectionView numberOfItemsInSection:0];
//    _attributeAttay = [[NSMutableArray alloc]init];
//    //先设定大圆的半径 取长和宽最短的
//    CGFloat radius = MIN(self.collectionView.frame.size.width, self.collectionView.frame.size.height)/2;
//    //计算圆心位置
//    CGPoint center = CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2);
//    //设置每个item的大小为50*50 则半径为25
//    for (int i=0; i<_itemCount; i++) {
//        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
//        //设置item大小
//        attris.size = CGSizeMake(50, 50);
//        //计算每个item的圆心位置
//        /*
//         .
//         . .
//         .   . r
//         .     .
//         .........
//         */
//        //计算每个item中心的坐标
//        //算出的x y值还要减去item自身的半径大小
//        float x = center.x+cosf(2*M_PI/_itemCount*i)*(radius-25);
//        float y = center.y+sinf(2*M_PI/_itemCount*i)*(radius-25);
//        
//        attris.center = CGPointMake(x, y);
//        [_attributeAttay addObject:attris];
//    }
//    
//    
//    
//}
////设置内容区域的大小
//-(CGSize)collectionViewContentSize{
//    return self.collectionView.frame.size;
//}
////返回设置数组
//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
//    return _attributeAttay;
//}

//// 确保能实时更新布局
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}
// 进行圆形布局,设置其每个元素的相关因素(主要是它的 frame,中心点)
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    // 创建可变数组,用于储存所有的布局因素
//    NSMutableArray *layoutAtts = [NSMutableArray array];
//    // 取出对应布局中的 collectionView 的元素的数目(为的就是给一个个cell 独立设置其的布局)
//    NSInteger count =  [self.collectionView numberOfItemsInSection:0];
//    // 设置每个 cell 的高度和宽度
//    CGFloat WH = 50;
//    // 取出圆形视图的中心点 (也就是 collectionView 的中心点)
//    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
//    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
//    // 设置 圆形布局半径
//    CGFloat randius = centerY- 30;
//    // 获得每个 cell 之间的间距 (所有 cell 平分了整个圆)
//    CGFloat angelMargin = M_PI * 2 / count;
//    // 遍历进行设置布局
//    for (int i = 0; i < count ; i ++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        // 创建对应索引的布局
//        UICollectionViewLayoutAttributes *layoutAtt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//        // 根据三角函数设置布局的中心点
//        CGFloat a = sin(i * angelMargin) * randius;
//        CGFloat b = cos(i * angelMargin) * randius;
//        layoutAtt.center = CGPointMake(centerX + a, b+ centerY);
//        layoutAtt.size = CGSizeMake(WH, WH);
//        [layoutAtts addObject:layoutAtt];
//    }
//    return layoutAtts;
//}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    UICollectionView * cUV = super.collectionView;
    
    //使用系统帮我们计算好的结果。
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    //第0个cell没有上一个cell
    for(int i = 1; i < [attributes count]; ++i) {
        //根据 maximumInteritemSpacing 计算出的当前Cell的 x 位置
        UICollectionViewLayoutAttributes * preAttr = attributes[i - 1];
        NSInteger origin = CGRectGetMaxX(preAttr.frame);
        CGFloat targetX = origin;
        
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
