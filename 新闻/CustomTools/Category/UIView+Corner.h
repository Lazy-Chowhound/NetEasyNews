//
//  UIView+Corner.h
//  正确圆角设置方式
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Corner)

- (void)dr_cornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;

- (void)dr_topCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;

- (void)dr_bottomCornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;
/**
 *  @brief             圆角化视图并对圆角部分进行描边
 *
 *  @param radius      圆角的半径
 *  @param bgColor     父视图的背景色
 *  @param borderColor 描边的颜色
 */
- (void)dr_cornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor;

- (void)removeDRCorner;

- (BOOL)hasDRCornered;

@end
