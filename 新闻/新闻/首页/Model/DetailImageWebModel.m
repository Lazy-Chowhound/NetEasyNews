//
//  DetailImageWebModel.m
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "DetailImageWebModel.h"


@implementation DetailImageWebModel

+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    DetailImageWebModel *imgModel = [[self alloc]init];
    imgModel.ref = dict[@"ref"];
    imgModel.pixel = dict[@"pixel"];
    imgModel.src = dict[@"src"];
    
    return imgModel;
}

@end
