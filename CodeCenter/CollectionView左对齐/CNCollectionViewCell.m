//
//  CNCollectionViewCell.m
//  CodeCenter
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 Five. All rights reserved.
//

#import "CNCollectionViewCell.h"

@implementation CNCollectionViewCell

- (void)reshow{
    _cnLabel.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
    
    _cnLabel.text = [NSString stringWithFormat:@"%u", _idx];
    
//    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:0.3];
}

@end
