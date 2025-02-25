//
//  CycleBannerCell.m
//  CycleScrollView
//
//  Created by 李浩铭 on 2019/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "CycleBannerCell.h"
#import "UIImageView+WebCache.h"

@interface CycleBannerCell()
@property (nonatomic , strong) UIImageView * imgView;
@end

@implementation CycleBannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imgView];
        self.imgView = imgView;
    }
    return self;
}

- (void)setCellDataWithUrl:(NSString *)imgUrl {
    if ([imgUrl hasPrefix:@"http"]) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
    } else {
        UIImage *image = [UIImage imageNamed:imgUrl];
        if (!image) {
            [UIImage imageWithContentsOfFile:imgUrl];
        }
        self.imgView.image = image;
    }
}

@end
