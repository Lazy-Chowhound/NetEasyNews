//
//  GYHSectorProgressView.m
//  GYHPhotoLoadingView
//
//  Created by 李浩铭 on 19/6/11.
//  Copyright © 2019年 apple. All rights reserved.
//


#import "GYHSectorProgressView.h"

@interface GYHSectorProgressView()
{
    CAShapeLayer *frontFillLayer;       //用来填充的图层
    UIBezierPath *frontFillBezierPath;  //用来填充的贝赛尔曲线
}
@end

@implementation GYHSectorProgressView

- (instancetype)initWithCenter:(CGPoint)center
{
    if (self = [super init]) {
        self.frame = CGRectMake(10, 10, 22, 22);
        self.center = center;
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    //创建填充图层
    frontFillLayer = [CAShapeLayer layer];
    frontFillLayer.fillColor = nil;
    frontFillLayer.strokeColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;
    frontFillLayer.lineWidth = self.frame.size.width;
    
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:25 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    border.lineWidth = 1.5f;
    
    [self.layer addSublayer:border];
    [self.layer addSublayer:frontFillLayer];
}

- (void)setProgressColor:(UIColor *)progressColor
{
    frontFillLayer.strokeColor = progressColor.CGColor;
}


- (void)setProgressValue:(CGFloat)progressValue
{
    frontFillBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.width/2 startAngle:-M_PI_2 endAngle:-M_PI_2 + progressValue * M_PI * 2 clockwise:YES];
    frontFillLayer.path = frontFillBezierPath.CGPath;
}

@end
