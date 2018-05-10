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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //注册Cell
    [_cnCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
    CGFloat w = arc4random() % 88 + 36;
    NSInteger h = collectionView.bounds.size.height / 6;
    return CGSizeMake(w, h);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];

    newCell.backgroundColor = [UIColor colorWithRed: arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
    
    return newCell;
}




@end
