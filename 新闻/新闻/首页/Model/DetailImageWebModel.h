//
//  DetailImageWebModel.h
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailImageWebModel : NSObject

@property (nonatomic, copy) NSString *src;
//图片尺寸
@property (nonatomic, copy) NSString *pixel;
//图片所处的位置 
@property (nonatomic, copy) NSString *ref;

+ (instancetype)detailImgWithDict:(NSDictionary *)dict;

@end
