//
//  BNRItemCell.h
//  HomePwner
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright (c) 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
//@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;

@property (nonatomic, copy) void(^actionBlock)(void);

@end
