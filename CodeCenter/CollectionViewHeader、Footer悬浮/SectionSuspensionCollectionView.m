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

///数据
@property(nonatomic) NSMutableArray * cnData;

///Header的高度
@property(nonatomic) NSMutableDictionary * headerHeight;

@end

@implementation SectionSuspensionCollectionView
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _headerHeight = [NSMutableDictionary new];
    
    //注册Cell
    [_cnCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [_cnCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader"];
    
    [_cnCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"];
    
    CNCollectionViewFlowLayout * layout = (CNCollectionViewFlowLayout *)_cnCollectionView.collectionViewLayout;
    layout.dataSource = self;
    
    //初始化数据源
    _cnData = [NSMutableArray new];
    for (NSInteger idx = 0; idx < 100; idx++) {
        NSMutableArray * sectionData = [NSMutableArray new];
        
        NSInteger cellCount = arc4random() % 10 + 1;
        for (NSInteger cellIdx = 0; cellIdx < cellCount; cellIdx++) {
            [sectionData addObject:@(cellIdx)];
        }
        
        [_cnData addObject:sectionData];
    }
    
    [_cnCollectionView reloadData];
}

#pragma mark - 点击事件

- (IBAction)add:(UIButton *)sender{
//    NSInteger section = arc4random() % _cnData.count;
    NSInteger section =0;
    
    NSMutableArray * cellDatas = _cnData[section];
    
    [cellDatas addObject:@(cellDatas.count)];
    
    [_cnCollectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:cellDatas.count - 1 inSection:section]]];
}

- (IBAction)delete:(UIButton *)sender{
    
}

- (IBAction)reload:(UIButton *)sender{
    [_cnCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

#pragma mark - CollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _cnData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray * cellDatas = _cnData[section];
    return cellDatas.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    NSNumber * h = _headerHeight[@(section)];
    if (h == nil){
        h = @([self headerStickyHeight:section] + (arc4random() % 50 + 50));
        _headerHeight[@(section)] = h;
    }
    
    return CGSizeMake(collectionView.bounds.size.width, h.integerValue);
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
    return CGSizeMake(collectionView.bounds.size.width, 44);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    newCell.backgroundColor = [UIColor colorWithRed: arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:0.25];
    
    return newCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray * cellDatas = _cnData[indexPath.section];
    [cellDatas removeObjectAtIndex:indexPath.row];
    
    [_cnCollectionView deleteItemsAtIndexPaths:@[indexPath]];
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
