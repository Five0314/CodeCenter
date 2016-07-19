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
    _cnLabel.backgroundColor = [UIColor colorWithRed:(255 / (_idx % 3) + 50) / 255.0 green:125 / 255.0 blue:125 / 255.0 alpha:1];
    
    NSMutableString * text = [NSMutableString new];
    for (NSUInteger idx = 0; idx < 100; idx++) {
        [text appendString:[NSString stringWithFormat:@"%ld", (unsigned long)_idx]];
    }
    _cnLabel.text = text;
    
//    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:0.3];
}

@end
