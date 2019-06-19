//
//  BigImageCell.h
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel;
@interface BigImageCell : UITableViewCell
@property (nonatomic , strong) DataModel *dataModel;
//标题
@property (nonatomic , weak) UILabel *titleL;
//描述
@property (nonatomic , weak) UILabel *lblSubtitle;
//跟帖
@property (nonatomic , weak) UILabel *lblReply;
//大图
@property (nonatomic , weak) UIImageView *image1;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
