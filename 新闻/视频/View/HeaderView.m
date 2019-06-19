//
//  HeaderView.m
//  新闻
//
//  Created by 李浩铭 on 19/6/11.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "HeaderView.h"
#import "TabbarButton.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        TabbarButton *btn = [[TabbarButton alloc]init];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(10, 10, 50, 100);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:btn];
    }
    return self;
}

-(void)btnClick:(TabbarButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(btntitle:url:)]) {
        [self.delegate btntitle:btn.titleLabel.text url:btn.titleLabel.text];
    }
}

@end
