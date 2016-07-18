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

@implementation LeftCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
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
