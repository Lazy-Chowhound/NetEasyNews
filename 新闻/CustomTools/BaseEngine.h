//
//  BaseEngine.h
//  新闻
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEngine : NSObject

+ (instancetype)shareEngine;

- (void)runRequestWithPara:(NSMutableDictionary *)para
                      path:(NSString *)path
                   success:(void(^)(id responseObject))success
                   failure:(void(^)(id error))failure;

@end
