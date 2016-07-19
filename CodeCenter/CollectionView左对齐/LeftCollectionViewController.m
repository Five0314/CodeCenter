//
//  LeftCollectionViewController.m
//  CodeCenter
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "LeftCollectionViewController.h"
#import "CNCollectionViewCell.h"

@interface LeftCollectionViewController ()

@property(weak, nonatomic) IBOutlet UICollectionView * cnCollectionView;

@end

@implementation LeftCollectionViewController{
    BOOL _isFirstShow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [_cnCollectionView reloadData];
//    [_cnCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:10000 / 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//    [_cnCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2500 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//    [_cnCollectionView scrollRectToVisible:CGRectMake(2500 * _cnCollectionView.bounds.size.width, 0, _cnCollectionView.bounds.size.width, _cnCollectionView.bounds.size.height) animated:false];
    
    [_cnCollectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc{
    [_cnCollectionView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [_cnCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:10000 / 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (!_isFirstShow && [keyPath isEqualToString:@"contentOffset"] && _cnCollectionView.contentOffset.x == 0){
//        NSLog(@" ========== %f", _cnCollectionView.contentOffset.x);
        _isFirstShow = true;
        [_cnCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:10000 / 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10000;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat w = arc4random() % 88 + 36;
//    NSInteger h = collectionView.bounds.size.height / 2;
//    return CGSizeMake(v, h);
    
    return collectionView.bounds.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CNCollectionViewCell * newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CNCollectionViewCell" forIndexPath:indexPath];
    newCell.idx = indexPath.row;
    [newCell reshow];
    
    return newCell;
}




@end
