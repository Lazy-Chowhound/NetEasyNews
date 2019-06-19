//
//  GYHSectorProgressView.h
//  GYHPhotoLoadingView
//
//  Created by 李浩铭 on 19/6/11.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHSectorProgressView : UIView

/**
 *  初始化，只需传入view的center即可
 */
- (instancetype)initWithCenter:(CGPoint)center;
/**
 *  进度值0-1.0之间
 */
@property (nonatomic,assign)CGFloat progressValue;

/**
 *  扇形颜色
 */
@property(nonatomic,strong)UIColor *progressColor;

@end
