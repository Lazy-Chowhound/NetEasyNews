//
//  HeaderView.h
//  新闻
//
//  Created by 李浩铭 on 19/6/11.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabbarButton;
@protocol ButtonClickDelegate<NSObject>

-(void)btntitle:(NSString *)btntitle url:(NSString *)url;
@end

@interface HeaderView : UIView

@property (nonatomic , weak) id<ButtonClickDelegate> delegate;

@end
