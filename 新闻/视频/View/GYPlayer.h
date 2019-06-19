//
//  GYPlayer.h
//  新闻
//
//  Created by 李浩铭 on 19/6/11.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYPlayer : UIView

@property (nonatomic , copy) void(^currentRowBlock)();

///title
@property (nonatomic , strong) NSString *title;
///url
@property (nonatomic , strong) NSString *mp4_url;
///当前在cell上的播放器的y值
@property (nonatomic) CGFloat currentOriginY;

- (void)removePlayer;
@end
