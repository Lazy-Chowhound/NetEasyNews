//
//  BaseViewController.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (BOOL)canSwipBack
{
    return YES;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
