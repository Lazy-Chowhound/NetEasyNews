//
//  DetailWebModel.h
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailWebModel : NSObject

//标题
@property (nonatomic, copy) NSString *title;
//发布时间
@property (nonatomic, copy) NSString *ptime;
//内容
@property (nonatomic, copy) NSString *body;
//配图 
@property (nonatomic, strong) NSArray *img;

+ (instancetype)detailWithDict:(NSDictionary *)dict;

@end
