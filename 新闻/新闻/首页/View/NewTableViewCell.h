//
//  PhotoTableViewCell.h
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewDataFrame;
@interface NewTableViewCell : UITableViewCell
@property (nonatomic , strong) NewDataFrame *dataFrame;

@property (nonatomic , weak) UIImageView *imageV;
@property (nonatomic , weak) UILabel *titleLabel;
@property (nonatomic , weak) UILabel *timeLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
