//
//  CNCollectionViewCell.h
//  CodeCenter
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 Five. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNCollectionViewCell : UICollectionViewCell

@property(weak, nonatomic) IBOutlet UILabel * cnLabel;

@property(nonatomic) NSUInteger idx;

- (void)reshow;
@end
