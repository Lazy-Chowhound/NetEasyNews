//
//  DetailWebModel.m
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "DetailWebModel.h"
#import "DetailImageWebModel.h"

@implementation DetailWebModel

+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    DetailWebModel *detail = [[self alloc]init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    
    NSArray *imgArray = dict[@"img"];
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
    for (NSDictionary *dict in imgArray) {
        DetailImageWebModel *imgModel = [DetailImageWebModel detailImgWithDict:dict];
        [temArray addObject:imgModel];
    }
    detail.img = temArray;
    
    return detail;
}

@end
