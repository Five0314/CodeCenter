//
//  CNCollectionViewFlowLayout.m
//  Pods
//
//  Created by mac on 16/9/4.
//
//

#import "CNCollectionViewFlowLayout.h"

@implementation CNCollectionViewFlowLayout

- (void)awakeFromNib{
    _parallaxHeaderHeight = 0;//视差视图的高度
    _parallaxHeaderStickyHeight = 0;//视差视图的悬浮高度
    _parallaxHeaderMaxHeight = 1000;//视差视图的最大高度(CollectionView一直下拉，视察视图会被拉伸，此参数就是限制拉伸的最大高度)
}

//- (void)prepareLayout {
//    [super prepareLayout];
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
//    if (!attributes && [kind isEqualToString:@"parallaxHeader"]) {
//        attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
//    }
//    return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
//    CGRect frame = attributes.frame;
//    frame.origin.y += _parallaxHeaderHeight;
//    attributes.frame = frame;
//    return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)elementKind  atIndexPath:(NSIndexPath *)elementIndexPath {
//    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingSupplementaryElementOfKind:elementKind atIndexPath:elementIndexPath];
//    
//    if ([elementKind isEqualToString:@"parallaxHeader"]) {
//        // sticky header do not need to offset
//        return nil;
//    } else {
//        // offset others
//        
//        CGRect frame = attributes.frame;
//        frame.origin.y += _parallaxHeaderHeight;
//        attributes.frame = frame;
//    }
//    
//    return attributes;
//}
//
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath{
//    
//    if ([elementKind isEqualToString:@"parallaxHeader"]) {
//        UICollectionViewLayoutAttributes * attribute = (UICollectionViewLayoutAttributes *)[self layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:elementIndexPath];
//        
//        [self updateParallaxHeaderAttributes:attribute];
//        return attribute;
//    } else {
//        return [super finalLayoutAttributesForDisappearingSupplementaryElementOfKind:elementKind atIndexPath:elementIndexPath];
//    }
//    return nil;
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
            CGRect rect = obj.frame;
            rect.origin.y += _parallaxHeaderHeight;
            obj.frame = rect;
            
            if ([obj representedElementKind] == nil){
                UICollectionViewLayoutAttributes * lastCellForSection = [lastCells objectForKey:@(obj.indexPath.section)];
                obj.zIndex = 0;
                
                if (lastCellForSection == nil || obj.indexPath.row > lastCellForSection.indexPath.row) {
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
                CGFloat stickyHeight = [self headerStickyHeight:obj.indexPath.section withHeadersStickyHeight:headerStickyHeight];
                [self updateHeaderAttributes:header lastCellAttributes:lastCells[indexPathKey] stickyHeight:stickyHeight];
            }
        }];
        
        ///视差Header
        if (_parallaxHeaderHeight > 0){
            UICollectionViewLayoutAttributes * parallaxHeader = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:@"parallaxHeader" withIndexPath:[NSIndexPath indexPathWithIndex:-1]];
            [self updateParallaxHeaderAttributes:parallaxHeader];
            [allItems insertObject:parallaxHeader atIndex:0];
        }
    }
    
    return allItems;
}

#pragma mark - Header
- (void)updateHeaderAttributes:(UICollectionViewLayoutAttributes *)attributes lastCellAttributes:(UICollectionViewLayoutAttributes *)lastCellAttributes
                  stickyHeight:(CGFloat)stickHeight{
    attributes.zIndex = 1024 + attributes.indexPath.section;
    
    CGRect rect = attributes.frame;
    
    CGFloat sectionMaxY = CGRectGetMaxY(lastCellAttributes.frame) - attributes.frame.size.height;
    
    CGFloat y = self.collectionView.contentOffset.y + self.collectionView.contentInset.top - (attributes.frame.size.height - stickHeight) + _parallaxHeaderStickyHeight;

    rect.origin.y = MIN(MAX(y, attributes.frame.origin.y), sectionMaxY);
    
//    NSLog(@"section: %ld CY: %f Y: %f MaxY: %f", attributes.indexPath.section, self.collectionView.contentOffset.y, rect.origin.y, sectionMaxY);

    attributes.frame = rect;
}

/**
 *  @author Five, 16-09-05 11:09:27
 *
 *  Heahder悬浮高度
 *
 *  @param section header的索引
 *  @param stickyHeights    悬浮高度集
 *
 *  @return 悬浮的高度
 */
- (CGFloat)headerStickyHeight:(NSInteger)section withHeadersStickyHeight:(NSMutableDictionary *)stickyHeights{
    NSNumber * stickyHeight = stickyHeights[@(section)];
    if (stickyHeight == nil){
        stickyHeight = @([_dataSource headerStickyHeight:section]);
        stickyHeights[@(section)] = stickyHeight;
    }
    return stickyHeight.integerValue;
}

#pragma mark - ParallaxHeader
- (void)updateParallaxHeaderAttributes:(UICollectionViewLayoutAttributes *)attributes{
    attributes.zIndex = 2000;
    
    CGRect rect = CGRectMake(0, 0, self.collectionView.bounds.size.width, _parallaxHeaderHeight);
    
    if (self.collectionView.contentOffset.y <= _parallaxHeaderHeight - _parallaxHeaderMaxHeight - self.collectionView.contentInset.top){
        rect.origin.y = _parallaxHeaderHeight - _parallaxHeaderMaxHeight;
        rect.size.height = _parallaxHeaderMaxHeight;
    }
    else if(self.collectionView.contentOffset.y <= -self.collectionView.contentInset.top){
        rect.origin.y = self.collectionView.contentOffset.y + self.collectionView.contentInset.top;//- (_parallaxHeaderHeight - _parallaxHeaderStickyHeight)
        rect.size.height = _parallaxHeaderHeight + fabs(self.collectionView.contentInset.top + self.collectionView.contentOffset.y);
    }
    else if(self.collectionView.contentOffset.y < (_parallaxHeaderHeight - _parallaxHeaderStickyHeight) - self.collectionView.contentInset.top){
        rect.origin.y = 0;
    }
    else{
        rect.origin.y = self.collectionView.contentOffset.y - (_parallaxHeaderHeight - _parallaxHeaderStickyHeight) + self.collectionView.contentInset.top;
    }
    
//    NSLog(@"Collection偏移量: %f       视差视图: %f        高度: %f", self.collectionView.contentOffset.y, rect.origin.y, rect.size.height);
    
    attributes.frame = rect;
}

- (CGSize)collectionViewContentSize {
    if (!self.collectionView.superview) {
        return CGSizeZero;
    }
    
    CGSize size = [super collectionViewContentSize];
    size.height += _parallaxHeaderHeight;
    return size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
