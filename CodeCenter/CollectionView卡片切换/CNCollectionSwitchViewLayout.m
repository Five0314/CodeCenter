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

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%ld", (long)indexPath.row);
    
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{

    //使用系统帮我们计算好的结果。
    CGRect newRect = CGRectMake(rect.origin.x - rect.size.width, rect.origin.y, rect.size.width * 3, rect.size.height);
    NSArray * attributes = [super layoutAttributesForElementsInRect:newRect];

    NSLog(@"---------------------------------------------------------------");
    
    UICollectionView * cUV = super.collectionView;
    double os = cUV.contentOffset.x;
    
    double cvHW = cUV.bounds.size.width * 0.5;
    double cvW = cUV.bounds.size.width;
    
    [attributes enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(UICollectionViewLayoutAttributes * cellAttributes, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        CGFloat cTC = os + cvHW - cellAttributes.center.x;//Cell的中心到屏幕中心的距离
        CGFloat uCTC = fabs(cTC);//Cell的中心到屏幕中心的距离的绝对值
        
        if (uCTC - cvW >= cvHW){
            cellAttributes.alpha = 0;
            NSLog(@"******************偏移量%f 中心间距%f 索引：%ld", cTC, uCTC, (long)cellAttributes.indexPath.row);
        }
        else {
            cellAttributes.alpha = 1;
            
            cellAttributes.zIndex = 1000 - fabs(os - CGRectGetMinX(cellAttributes.frame));//层级，防止被遮盖
            
            CGFloat scale = 1 - fabs(os + cvHW - cellAttributes.center.x) * 2 / cUV.bounds.size.width * 0.2;//缩放比例
            if (scale < 0.8){
                scale = 0.8;
            }
            CGAffineTransform cellTransform = CGAffineTransformMakeScale(scale, scale);
            
            if (uCTC >= cvHW){
                if (cTC < 0){//右边的
                    CGFloat xtransform = (cTC + cvHW) * (cUV.bounds.size.width + 20) * 2 / cUV.bounds.size.width;
                    NSLog(@"==================偏移量%f 右的偏移量%f 索引：%ld", cTC, xtransform, (long)cellAttributes.indexPath.row);
                    cellTransform = CGAffineTransformTranslate(cellTransform, xtransform, 0);
                }
                else{//左边的
                    CGFloat xtransform = (cTC - cvHW) * (cUV.bounds.size.width + 20) * 2 / cUV.bounds.size.width;
                    NSLog(@"==================偏移量%f 左的偏移量%f 索引：%ld", cTC, xtransform, (long)cellAttributes.indexPath.row);
                    cellTransform = CGAffineTransformTranslate(cellTransform, xtransform, 0);
                }
            }
            else{
                NSLog(@"------------------偏移量%f 中心间距%f 索引：%ld", cTC, uCTC, (long)cellAttributes.indexPath.row);
            }
            
            cellAttributes.transform = cellTransform;
        }
        
    }];
    
    return attributes;
}

@end

//
//cellAttributes.zIndex = 1000 - fabs(os - CGRectGetMinX(cellAttributes.frame));//层级，防止被遮盖
//
//CGFloat scale = 1 - fabs(os + cvHW - cellAttributes.center.x) * 2 / cUV.bounds.size.width * 0.2;//缩放比例
//if (scale < 0.8){
//    scale = 0.8;
//}
//CGAffineTransform cellTransform = CGAffineTransformMakeScale(scale, scale);
//
//CGFloat cellCenterToScreenCenter = os + cvHW - cellAttributes.center.x;//Cell的中心到屏幕中心的距离
//CGFloat uCTC = fabs(cellCenterToScreenCenter);//Cell的中心到屏幕中心的距离的绝对值
//
//if (uCTC - cvW > cvW){
//    if (uCTC - cvW > 640){
//        cellAttributes.alpha = 0;
//    }
//    //            else{
//    //                cellAttributes.alpha = 1 - (uCTC - cvW - 20) / 20;
//    //            }
//    NSLog(@"******************偏移量%f 索引：%ld", cellCenterToScreenCenter, (long)cellAttributes.indexPath.row);
//}
//else {
//    cellAttributes.alpha = 1;
//    
//    if (uCTC >= cvHW){
//        if (cellCenterToScreenCenter < 0){//右边的
//            CGFloat xtransform = (cellCenterToScreenCenter + cvHW) * (cUV.bounds.size.width + 20) * 2 / cUV.bounds.size.width;
//            //                    NSLog(@"==================偏移量%f 右的偏移量%f 索引：%ld", cellCenterToScreenCenter, xtransform, (long)cellAttributes.indexPath.row);
//            cellTransform = CGAffineTransformTranslate(cellTransform, xtransform, 0);
//        }
//        else{//左边的
//            CGFloat xtransform = (cellCenterToScreenCenter - cvHW) * (cUV.bounds.size.width + 20) * 2 / cUV.bounds.size.width;
//            //                    NSLog(@"==================偏移量%f 左的偏移量%f 索引：%ld", cellCenterToScreenCenter, xtransform, (long)cellAttributes.indexPath.row);
//            cellTransform = CGAffineTransformTranslate(cellTransform, xtransform, 0);
//        }
//    }
//}
//
//
//
//
//
//
//
//
//double colleciontViewHalfWidth = cUV.bounds.size.width * 0.5;
//
//[attributes enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(UICollectionViewLayoutAttributes * cellAttributes, NSUInteger idx, BOOL * _Nonnull stop) {
//    cellAttributes.zIndex = 1000 - fabs(os - CGRectGetMinX(cellAttributes.frame));//层级，防止被遮盖
//    
//    CGFloat scale = 1 - fabs(os + colleciontViewHalfWidth - cellAttributes.center.x) * 2 / cUV.bounds.size.width * 0.2;//缩放比例
//    if (scale < 0.8){
//        scale = 0.8;
//    }
//    CGAffineTransform cellTransform = CGAffineTransformMakeScale(scale, scale);
//    
//    CGFloat cellCenterToScreenCenter = os + colleciontViewHalfWidth - cellAttributes.center.x;//Cell的中心到屏幕中心的距离
//    
//    NSLog(@"==================偏移量%f 索引：%ld", cellCenterToScreenCenter, (long)cellAttributes.indexPath.row);
//    
//    if(fabs(cellCenterToScreenCenter) > colleciontViewHalfWidth){
//        CGFloat xtransform = (cellCenterToScreenCenter > 0 ? (cellCenterToScreenCenter - colleciontViewHalfWidth) : (cellCenterToScreenCenter + colleciontViewHalfWidth)) * (cUV.bounds.size.width + 20) * 2 / cUV.bounds.size.width;
//        cellTransform = CGAffineTransformTranslate(cellTransform, xtransform, 0);
//        
//        CGFloat overXtransform = fabs(cellCenterToScreenCenter) - cUV.bounds.size.width;
//        if (overXtransform > 20.1){
//            //                    NSLog(@"超过 20 偏移量 %f 索引：%ld %f %f %f ", overXtransform, (long)cellAttributes.indexPath.row, os, colleciontViewHalfWidth, cellAttributes.center.x);
//            if (overXtransform > 40){
//                overXtransform = 40;
//            }
//            
//            cellAttributes.alpha = 1 - (overXtransform - 20) / 20;
//        }
//        else if(overXtransform > - cUV.bounds.size.width - 20.01){
//            //                    NSLog(@"20 以内 偏移量 %f 索引：%ld %f %f %f ", overXtransform, (long)cellAttributes.indexPath.row, os, colleciontViewHalfWidth, cellAttributes.center.x);
//            cellAttributes.alpha = 1;
//        }
//        else{
//            //                    NSLog(@" ++++++++++ 偏移量 %f 索引：%ld %f %f %f ", overXtransform, (long)cellAttributes.indexPath.row, os, colleciontViewHalfWidth, cellAttributes.center.x);
//            cellAttributes.alpha = 0;
//        }
//    }
//    else{
//        //                NSLog(@" ********** 偏移量 %f 索引：%ld %f %f %f ", cellCenterToScreenCenter, (long)cellAttributes.indexPath.row, os, colleciontViewHalfWidth, cellAttributes.center.x);
//        cellAttributes.alpha = 1;
//    }
//    
//    cellAttributes.transform = cellTransform;
//    
//}];
