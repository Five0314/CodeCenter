//
//  CNCollectionViewFlowLayout.m
//  Pods
//
//  Created by mac on 16/9/4.
//
//

#import "CNCollectionViewFlowLayout.h"

@implementation CNCollectionViewFlowLayout

//- (void)awakeFromNib{
////    _headerSuspension = true;
//    
////    _headerMinHeight = 80;
////    
////    _parallaxHeaderReferenHeight = 0;
////    _parallaxHeaderMinHeight = 0;
//}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
//    NSLog(@" ");
    
    NSMutableArray * allItems = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];

    if (_dataSource != nil && [_dataSource respondsToSelector:@selector(headerStickyHeight:)]){
        //遍历寻找所有的Header、Footer、每个Section的最后一个Cell
        NSMutableDictionary * headers = [NSMutableDictionary new];
        NSMutableDictionary * lastCells = [NSMutableDictionary new];
        NSMutableDictionary * headerStickyHeight = [NSMutableDictionary new];
        
        [allItems enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj representedElementKind] == nil){
                UICollectionViewLayoutAttributes * lastCellForSection = [lastCells objectForKey:@(obj.indexPath.section)];
                
                if (lastCellForSection == nil || obj.indexPath.row > lastCellForSection.indexPath.row) {
                    obj.zIndex = 0;
                    
                    [lastCells setObject:obj forKey:@(obj.indexPath.section)];
                }
            }
            else{
                BOOL isHeader = [[obj representedElementKind] isEqualToString:UICollectionElementKindSectionHeader];
                if (isHeader) {
                    [headers setObject:obj forKey:@(obj.indexPath.section)];
                }
            }
        }];
        
        [lastCells enumerateKeysAndObjectsUsingBlock:^(NSNumber * key, UICollectionViewLayoutAttributes * obj, BOOL *stop) {
            NSIndexPath *indexPath = [obj indexPath];
            NSNumber *indexPathKey = @(indexPath.section);
            
            UICollectionViewLayoutAttributes * header = headers[indexPathKey];
            if (header == nil) {
                header = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section]];
                
                if (!CGSizeEqualToSize(CGSizeZero, header.frame.size)) {
                    [allItems addObject:header];
                }
            }
            
            if (!CGSizeEqualToSize(CGSizeZero, header.frame.size)) {
                CGFloat stickyHeight = [self headerStickyHeight:obj.indexPath.section fromData:headerStickyHeight];
                [self updateHeaderAttributes:header lastCellAttributes:lastCells[indexPathKey] stickyHeight:stickyHeight];
            }
        }];
    }
    
    return allItems;
}

- (void)updateHeaderAttributes:(UICollectionViewLayoutAttributes *)attributes lastCellAttributes:(UICollectionViewLayoutAttributes *)lastCellAttributes stickyHeight:(CGFloat)stickHeight{
    attributes.zIndex = 1024;
    
    CGRect rect = attributes.frame;
    
    CGFloat sectionMaxY = CGRectGetMaxY(lastCellAttributes.frame) - attributes.frame.size.height;
    
    CGFloat y = self.collectionView.contentOffset.y + self.collectionView.contentInset.top - (attributes.frame.size.height - stickHeight);

    rect.origin.y = MIN(MAX(y, attributes.frame.origin.y), sectionMaxY);

    attributes.frame = rect;
}

/**
 *  @author Five, 16-09-05 11:09:27
 *
 *  Heahder悬浮高度
 *
 *  @param section header的索引
 *  @param data    悬浮高度集
 *
 *  @return 悬浮的高度
 */
- (CGFloat)headerStickyHeight:(NSInteger)section fromData:(NSMutableDictionary *)data{
    NSNumber * stickyHeight = data[@(section)];
    if (stickyHeight == nil){
        stickyHeight = @([_dataSource headerStickyHeight:section]);
        data[@(section)] = stickyHeight;
    }
    return stickyHeight.integerValue;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
