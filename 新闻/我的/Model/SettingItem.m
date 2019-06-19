//
//  SettingItem.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/12.
//  Copyright 2019年 apple. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem


+ (instancetype)itemWithItem:(NSString *)icon title:(NSString *)title
{
    SettingItem *item = [[self alloc]init];
    item.icon = icon;
    item.title = title;
    
    return item;
}

+ (instancetype)itemWithItem:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle
{
    SettingItem *item = [[self alloc]init];
    item.icon = icon;
    item.title = title;
    item.subtitle = subtitle;
    return item;
}
@end
