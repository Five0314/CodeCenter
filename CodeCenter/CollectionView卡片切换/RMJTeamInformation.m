//
//  RMJTeamInformation.m
//  CodeCenter
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "RMJTeamInformation.h"
#import "CNCollectionViewCell.h"
#import "CodeCenter-swift.h"
#import "CNCoderCenter.h"
#import "CNCollectionSwitchViewLayout.h"//样式

@interface RMJTeamInformation()

@property(nonatomic) UICollectionView * cnCollectionView;

@end

@implementation RMJTeamInformation{
    BOOL _isFirstShow;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = false;
        
        //
        CNCollectionSwitchViewLayout * lo = [CNCollectionSwitchViewLayout new];
        lo.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cnCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:lo];
        _cnCollectionView.pagingEnabled = true;
        _cnCollectionView.backgroundColor = [UIColor clearColor];
        _cnCollectionView.clipsToBounds = false;
        _cnCollectionView.showsHorizontalScrollIndicator = false;
        _cnCollectionView.showsVerticalScrollIndicator = false;
        _cnCollectionView.delegate = self;
        _cnCollectionView.dataSource = self;
        [self addSubview:_cnCollectionView];
        
        _cnCollectionView.translatesAutoresizingMaskIntoConstraints = false;
        NSArray * cs = [_cnCollectionView constraintsOC:self top:@(0) bottom:@(0) leading:@(0) trailing:@(0)];
        [self addConstraints:cs];
        
        //注册Cell
        [_cnCollectionView registerNib:[UINib nibWithNibName:@"CNCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CNCollectionViewCell"];
        
        //刷新界面
        [_cnCollectionView reloadData];
        
        //添加监听
        [_cnCollectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc{
    [_cnCollectionView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (!_isFirstShow && [keyPath isEqualToString:@"contentOffset"] && _cnCollectionView.contentOffset.x == 0){
        //        NSLog(@" ========== %f", _cnCollectionView.contentOffset.x);
        _isFirstShow = true;
        [_cnCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:10000 / 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10000;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CNCollectionViewCell * newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CNCollectionViewCell" forIndexPath:indexPath];
    newCell.cnCollectionView = _cnCollectionView;
    newCell.idx = indexPath.row;
    [newCell reshow];
    
//    NSInteger r = 255 / (indexPath.row % 255 % 3) + 50;
//    newCell.cnLabel.backgroundColor = [UIColor colorWithRed:r / 255.0 green:125 / 255.0 blue:125 / 255.0 alpha:1];
    
    return newCell;
}

@end
