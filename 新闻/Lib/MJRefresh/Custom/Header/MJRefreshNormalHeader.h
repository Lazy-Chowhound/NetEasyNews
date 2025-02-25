//
//  MJRefreshNormalHeader.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2019年 小码哥. All rights reserved.
//

#import "MJRefreshStateHeader.h"

@interface MJRefreshNormalHeader : MJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end
