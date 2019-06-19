//
//  SettingHeaderView.h
//  新闻
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingHeaderView : UIView

@property (nonatomic , weak) UIImageView *photoimageV;

@property (nonatomic , copy) void(^loginBlock)();
@end
