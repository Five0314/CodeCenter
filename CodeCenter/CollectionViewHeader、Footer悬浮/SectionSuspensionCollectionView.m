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
    return CGSizeMake(collectionView.bounds.size.width, [self headerStickyHeight:section] + (arc4random() % 50 + 50));
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
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
            lbl.tag = 1234;
            [cell addSubview:lbl];
            
            lbl.translatesAutoresizingMaskIntoConstraints = false;
            NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
            NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
            NSLayoutConstraint * right = [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
            [cell addConstraints:@[top, bottom, left, right]];
        }
        
        cell.backgroundColor = [UIColor colorWithRed: arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
        
        NSInteger h = [self headerStickyHeight:indexPath.section];
        if(h > 0){
            lbl.text = [NSString stringWithFormat:@"    %ld     行高 %f      悬浮高度 %ld", indexPath.section, cell.bounds.size.height, h];
        }
        else{
            lbl.text = [NSString stringWithFormat:@"    %ld", indexPath.section];
        }
        
        return cell;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView * cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"UICollectionElementKindSectionFooter"
                                                                                   forIndexPath:indexPath];
        
        UILabel * lbl = [cell viewWithTag:12345];
        if (lbl == nil){
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
            lbl.tag = 12345;
            [cell addSubview:lbl];
            
            lbl.translatesAutoresizingMaskIntoConstraints = false;
            NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
            NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
            NSLayoutConstraint * right = [NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
            [cell addConstraints:@[top, bottom, left, right]];
        }
        lbl.text = [NSString stringWithFormat:@"%ld", indexPath.section];
        
        cell.backgroundColor = [UIColor colorWithRed: arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
        
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
    else if(section == 1){
        return 10;
    }
    else if(section == 2){
        return 90;
    }
    else if(section == 3){
        return 20;
    }
    else if(section == 4){
        return 80;
    }
    else if(section == 5){
        return 30;
    }
    else if(section == 6){
        return 70;
    }
    else if(section == 7){
        return 40;
    }
    else if(section == 8){
        return 60;
    }
    else if(section == 9){
        return 50;
    }
    
    return 0;
}

@end
