//
//  SettingHeaderView.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "SettingHeaderView.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>


@interface SettingHeaderView()<UIAlertViewDelegate>

@end

@implementation SettingHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.6*SCREEN_WIDTH);
        self.backgroundColor = [UIColor colorWithRed:186/255.0f green:71/255.0f blue:58/255.0f alpha:1];
        
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = CGRectMake(self.frame.size.width/2-40, self.frame.size.height/2-40, 80, 80);
        imageV.image = [UIImage imageNamed:@"comment_profile_default"];
        [self addSubview:imageV];
        [imageV.layer setCornerRadius:40];
        imageV.clipsToBounds = YES;
        imageV.userInteractionEnabled = YES;
        self.photoimageV = imageV;
    }
    return self;
}

@end
