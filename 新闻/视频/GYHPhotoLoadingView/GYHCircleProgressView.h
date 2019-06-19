//
//  GYHCircleProgressView.h
//  GYHPhotoLoadingView
//
//  Created by 李浩铭 on 19/6/11.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHCircleProgressView : UIView

// 只需创建初始化view，并设置frame即可使用
// 默认线宽为3.0f，进度条的轨道颜色为gray，进度条的颜色为red
// 如果需要更改，在外部进行赋值
/**
 *  加载的进度
 */
@property (nonatomic,assign)CGFloat progressValue;

/**
 *  边宽
 */
@property(nonatomic,assign) CGFloat progressStrokeWidth;

/**
 *  进度条颜色
 */
@property(nonatomic,strong)UIColor *progressColor;

/**
 *  进度条轨道颜色
 */
@property(nonatomic,strong)UIColor *progressTrackColor;
@end
