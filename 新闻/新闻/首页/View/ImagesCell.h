//
//  ImagesCell.h
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel;
@interface ImagesCell : UITableViewCell
@property (nonatomic , strong) DataModel *dataModel;

//标题
@property (nonatomic , weak) UILabel *titleL;
//跟帖数
@property (nonatomic , weak) UILabel *lblReply;
//多图
@property (nonatomic , weak) UIImageView *image1;
@property (nonatomic , weak) UIImageView *image2;
@property (nonatomic , weak) UIImageView *image3;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
