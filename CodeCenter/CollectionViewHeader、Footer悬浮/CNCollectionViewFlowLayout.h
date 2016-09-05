//
//  CNCollectionViewFlowLayout.h
//  Pods
//
//  Created by mac on 16/9/4.
//
//

#import <UIKit/UIKit.h>

@protocol CNCollectionViewFlowLayoutDataSource <NSObject>

/**
 *  @author Five, 16-09-05 11:09:10
 *
 *  Header的最小高度，高度 > 0 才有悬浮效果
 *
 *  @param section Header的索引
 *
 *  @return 悬浮高度
 */
- (CGFloat)headerStickyHeight:(NSInteger)section;

@end

@interface CNCollectionViewFlowLayout : UICollectionViewFlowLayout


@property(nonatomic) id<CNCollectionViewFlowLayoutDataSource> dataSource;


//@property(nonatomic) CGFloat headerMinHeight;
//
///**
// *  @author Five, 16-09-05 09:09:50
// *
// *  参考高度
// */
//@property(nonatomic) CGFloat parallaxHeaderReferenHeight;
//
///**
// *  @author Five, 16-09-05 09:09:58
// *
// *  最小高度
// */
//@property(nonatomic) CGFloat parallaxHeaderMinHeight;


@end
