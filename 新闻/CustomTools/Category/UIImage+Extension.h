//
//  UIImage+Extension.h
//  
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)resizableImage:(NSString *)name;
/* 裁剪圆形图片 */
+ (UIImage *)clipImage:(UIImage *)image;
@end
