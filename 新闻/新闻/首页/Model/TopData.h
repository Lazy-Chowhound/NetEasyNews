//
//  TopData.h
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopData : NSObject

//滚动条图片
@property (nonatomic , copy) NSString *imgsrc;
//滚动条标题
@property (nonatomic , copy) NSString *title;
//链接
@property (nonatomic , copy) NSString *url;
//imgurl
@property (nonatomic , copy) NSString *imgurl;
// 详细内容
@property (nonatomic , copy) NSString *note;
//标题
@property (nonatomic , copy) NSString *setname;

@property (nonatomic , copy) NSString *imgtitle;

@end
