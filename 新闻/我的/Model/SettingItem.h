//
//  SettingItem.h
//  新闻
//
//  Created by 李浩铭 on 2019/6/12.
//  Copyright 2019年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SettingItemOption)();

@interface SettingItem : NSObject
//图标
@property(nonatomic,copy)NSString *icon;
//标题
@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,copy)SettingItemOption optionHandler;

+ (instancetype)itemWithItem:(NSString *)icon title:(NSString *)title;

+ (instancetype)itemWithItem:(NSString *)icon title:(NSString *)title subtitle:(NSString *)subtitle;

@end
