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
 *  Header的悬浮高度，高度 > 0 才有悬浮效果
 *
 *  @param section Header的索引
 *
 *  @return 悬浮高度
 */
- (CGFloat)headerStickyHeight:(NSInteger)section;
//
//#pragma mark - parallaxHeader
//
///**
// *  @author Five, 16-09-05 11:09:10
// *
// *  视差Header的高度
// *
// *  @param section Header的索引
// *
// *  @return 高度
// */
//- (CGFloat)parallaxHeaderHeight:(NSInteger)section;
//
///**
// *  @author Five, 16-09-05 11:09:10
// *
// *  视差Header的悬浮高度，高度 > 0 才有悬浮效果
// *
// *  @param section Header的索引
// *
// *  @return 悬浮高度
// */
//- (CGFloat)parallaxHeaderStickyHeight:(NSInteger)section;


@end

@interface CNCollectionViewFlowLayout : UICollectionViewFlowLayout


@property(nonatomic) id<CNCollectionViewFlowLayoutDataSource> dataSource;

/**
 *  @author Five, 16-09-07 11:09:24
 *
 *  视差视图的高度
 */
@property(nonatomic) CGFloat parallaxHeaderHeight;

/**
 *  @author Five, 16-09-07 11:09:11
 *
 *  视差视图的悬浮高度
 */
@property(nonatomic) CGFloat parallaxHeaderStickyHeight;

/**
 *  @author Five, 16-09-07 11:09:54
 *
 *  视差视图的最大高度(CollectionView一直下拉，视察视图会被拉伸，此参数就是限制拉伸的最大高度)
 */
@property(nonatomic) CGFloat parallaxHeaderMaxHeight;

@end
