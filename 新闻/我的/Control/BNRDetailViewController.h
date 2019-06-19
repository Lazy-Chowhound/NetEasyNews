//
//  BNRDetailViewController.h
//  HomePwner
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright (c) 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController <UIViewControllerRestoration>

@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);
- (instancetype)initForNewItem:(BOOL) isNew;

@end
