//
//  TabbarView.h
//  新闻
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarView : UIView

@property (nonatomic , copy) void (^btnSelectBlock)(int to);

- (void)selectIndex:(int)index;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
