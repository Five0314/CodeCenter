//
//  CNCollectionSwitchViewLayout.m
//  CodeCenter
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "CNCollectionSwitchViewLayout.h"

@implementation CNCollectionSwitchViewLayout

// 确保能实时更新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    
//    NSLog(@"=================");
    
    //使用系统帮我们计算好的结果。
    NSArray * attributes = [super layoutAttributesForElementsInRect:rect];
    
//    UICollectionViewLayoutAttributes * currentLayoutAttributes;
//    
//    for (UICollectionViewLayoutAttributes * la in attributes){
//        if (CGRectGetMinX(la.frame) < cUV.contentOffset.x && cUV.contentOffset.x < CGRectGetMaxX(la.frame)){
//            currentLayoutAttributes = la;
//            currentLayoutAttributes.zIndex = 1000;
//            NSLog(@"transform:%f, %f, %f, %f, %f, %f", la.transform.a, la.transform.b, la.transform.c, la.transform.d, la.transform.tx, la.transform.ty);
//        }
//        else{
//            la.zIndex = 1;
//        }
//    }
    
//    if (currentLayoutAttributes != nil){
        NSLog(@"---------------------------------------------------------------");
    UICollectionView * cUV = super.collectionView;
    double os = cUV.contentOffset.x;
    [attributes enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(UICollectionViewLayoutAttributes * cellAttributes, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        //            if(CGRectGetMaxX(obj.frame) <= cUV.contentOffset.x){
        //                NSLog(@"《 ========《 左边消失的 CellCenter：%f CellX：%f 偏移量：%f 索引：%u", obj.center.x, obj.frame.origin.x, cUV.contentOffset.x, obj.indexPath.row);
        //            }
        //            else if(obj.center.x > cUV.contentOffset.x && CGRectGetMinX(obj.frame) < cUV.contentOffset.x){
        //                NSLog(@"《 左移的 CellCenter：%f CellX：%f 偏移量：%f 索引：%u", obj.center.x, obj.frame.origin.x, cUV.contentOffset.x, obj.indexPath.row);
        //            }
        //            else if(obj.center.x < cUV.contentOffset.x && CGRectGetMaxX(obj.frame) > cUV.contentOffset.x){
        //                NSLog(@" 》右移的 CellCenter：%f CellX：%f 偏移量：%f 索引：%u", obj.center.x, obj.frame.origin.x, cUV.contentOffset.x, obj.indexPath.row);
        //            }
        //            else if(CGRectGetMinX(obj.frame) >= cUV.contentOffset.x + [UIScreen mainScreen].bounds.size.width){
        //                NSLog(@" 》======== 》 右边消失的 CellCenter：%f CellX：%f 偏移量：%f 索引：%u", obj.center.x, obj.frame.origin.x, cUV.contentOffset.x, obj.indexPath.row);
        //            }
        //            else{
        //                NSLog(@"啦啦啦啦 CellCenter：%f CellX：%f 偏移量：%f 索引：%u", obj.center.x, obj.frame.origin.x, cUV.contentOffset.x, obj.indexPath.row);
        //            }
        cellAttributes.zIndex = 1000 - fabs(os - CGRectGetMinX(cellAttributes.frame));
        
        if (CGRectGetMaxX(cellAttributes.frame) <= os){//左边已经消失掉
//            cellAttributes.transform = CGAffineTransformMakeTranslation(os - CGRectGetMaxX(cellAttributes.frame), 0);
//             NSLog(@"《 ========《 左边消失的 CellCenter：%f CellX：%f 偏移量：%f 索引：%ld", cellAttributes.center.x, cellAttributes.frame.origin.x, cUV.contentOffset.x, (long)cellAttributes.indexPath.row);
            
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.8, 0.8);
            CGFloat xtransform = cUV.bounds.size.width + 20;
            cellAttributes.transform = CGAffineTransformTranslate(scaleTransform, xtransform, 0);
//            cellAttributes.zIndex = 0;
            
            NSLog(@"左边已经消失掉 %f", xtransform);
        }
        else{
            if (cellAttributes.center.x <= os){//左边开始隐藏的
//                NSLog(@"《 ========《 左边开始隐藏的 CellCenter：%f CellX：%f 偏移量：%f 索引：%ld", cellAttributes.center.x, cellAttributes.frame.origin.x, cUV.contentOffset.x, (long)cellAttributes.indexPath.row);
//                cellAttributes.transform = CGAffineTransformMakeTranslation(os - CGRectGetMaxX(cellAttributes.frame), 0);
//                CGFloat scale = (1 - (os - cellAttributes.center.x) / 100) * 0.8;
//                CGFloat scale = 1 - fabs(CGRectGetMinX(cellAttributes.frame) - os) / cUV.bounds.size.width * 0.2;
//                NSLog(@"左边开始隐藏的 %f", scale);
                CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.8, 0.8);
                CGFloat xtransform = (os - cellAttributes.center.x) * (cUV.bounds.size.width + 20) * 2 / cUV.bounds.size.width;
                NSLog(@"左边开始隐藏的 %f", xtransform);
                cellAttributes.transform = CGAffineTransformTranslate(scaleTransform, xtransform, 0);
//                cellAttributes.zIndex = 0;
            }
            else{
                if (CGRectGetMinX(cellAttributes.frame) <= os){//左移的
//                    NSLog(@"《 ========《 左移的 CellCenter：%f CellX：%f 偏移量：%f 索引：%ld", cellAttributes.center.x, cellAttributes.frame.origin.x, cUV.contentOffset.x, (long)cellAttributes.indexPath.row);
                    CGFloat scale = 1 - fabs(CGRectGetMinX(cellAttributes.frame) - os) * 2 / cUV.bounds.size.width  * 0.2;
                    NSLog(@"左移的 %f", scale);
                    cellAttributes.transform = CGAffineTransformMakeScale(scale, scale);
                    
                }
                else{
                    if (cellAttributes.center.x <= os + cUV.bounds.size.width){//右移的
//                        NSLog(@" 》======== 》 右移的 CellCenter：%f CellX：%f 偏移量：%f 索引：%ld", cellAttributes.center.x, cellAttributes.frame.origin.x, cUV.contentOffset.x, (long)cellAttributes.indexPath.row);
                    
                     }
                     else{
                         if (CGRectGetMinX(cellAttributes.frame) <= os + cUV.bounds.size.width){//右边开始隐藏的
//                             NSLog(@" 》======== 》 右边开始隐藏的 CellCenter：%f CellX：%f 偏移量：%f 索引：%ld", cellAttributes.center.x, cellAttributes.frame.origin.x, cUV.contentOffset.x, (long)cellAttributes.indexPath.row);
                             
                         }
                         else{//右边已经消失的
//                             NSLog(@" 》======== 》 右边已经消失的 CellCenter：%f CellX：%f 偏移量：%f 索引：%ld", cellAttributes.center.x, cellAttributes.frame.origin.x, cUV.contentOffset.x, (long)cellAttributes.indexPath.row);
                             
                         }
                     }
                }
            }
        }
    }];
//    }
    
    return attributes;
}

@end
