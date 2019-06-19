//
//  NSString+Extension.h
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright 2019年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGRect)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
