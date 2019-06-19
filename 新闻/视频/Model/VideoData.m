//
//  VideoData.m
//  新闻
//
//  Created by 李浩铭 on 19/6/11.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "VideoData.h"
#import "NSDate+gyh.h"

@implementation VideoData

-(NSString *)ptime
{
    NSString *str1 = [_ptime substringToIndex:10];
    str1 = [str1 substringFromIndex:5];

    return str1;
}

@end
