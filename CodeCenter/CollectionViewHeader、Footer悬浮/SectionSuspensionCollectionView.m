//
//  SectionSuspensionCollectionView.m
//  CodeCenter
//
//  Created by mac on 16/9/4.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "SectionSuspensionCollectionView.h"
#import "CNCollectionViewFlowLayout.h"

@interface SectionSuspensionCollectionView ()

@property(weak, nonatomic) IBOutlet UICollectionView * cnCollectionView;

@end

@implementation SectionSuspensionCollectionView
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //注册Cell
    [_cnCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [_cnCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader"];
    
    [_cnCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"];
    
    CNCollectionViewFlowLayout * layout = (CNCollectionViewFlowLayout *)_cnCollectionView.collectionViewLayout;
    layout.dataSource = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 100);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView * cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"UICollectionElementKindSectionHeader"
                                                                                   forIndexPath:indexPath];
        UILabel * lbl = [cell viewWithTag:1234];
        if (lbl == nil){
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, 100)];
            lbl.tag = 1234;
            lbl.backgroundColor = [UIColor colorWithRed: arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
            [cell addSubview:lbl];
        }
        lbl.text = [NSString stringWithFormat:@"%ld", indexPath.section];
        
        return cell;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView * cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"UICollectionElementKindSectionFooter"
                                                                                   forIndexPath:indexPath];
        
        UILabel * lbl = [cell viewWithTag:12345];
        if (lbl == nil){
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, 100)];
            lbl.tag = 12345;
            lbl.backgroundColor = [UIColor colorWithRed: arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
            [cell addSubview:lbl];
        }
        lbl.text = [NSString stringWithFormat:@"%ld", indexPath.section];
        
        return cell;
    }
    
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = arc4random() % 88 + 36;
//    NSInteger h = collectionView.bounds.size.height / 6;
    return CGSizeMake(w, 150);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    newCell.backgroundColor = [UIColor colorWithRed: arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
    
    return newCell;
}

#pragma mark - CNCollectionViewFlowLayoutDataSource
- (CGFloat)headerStickyHeight:(NSInteger)section{
    if (section == 0){
        return 100;
    }
    else if(section == 2){
        return 60;
    }
    
    return 0;
//    return (section % 5 + 1) * 20;
}

@end
