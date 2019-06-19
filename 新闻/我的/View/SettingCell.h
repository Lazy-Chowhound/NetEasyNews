//
//  SettingCell.h
//  新闻
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingItem;
@interface SettingCell : UITableViewCell
@property(nonatomic,strong)SettingItem *item;

+(instancetype)cellWithTableView:(UITableView *)tableview;
@end
