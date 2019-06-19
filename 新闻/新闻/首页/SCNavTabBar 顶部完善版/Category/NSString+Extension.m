//
//  NSString+Extension.m
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright 2019年 apple. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGRect)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
}
@end
