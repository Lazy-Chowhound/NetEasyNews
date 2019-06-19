//
//  GridViewCell.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "GridViewCell.h"

@interface GridViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *livePhotoBadgeImageView;

@end

@implementation GridViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _livePhotoBadgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28.f, 28.f)];
    [self.contentView addSubview:_livePhotoBadgeImageView];
}

- (void)setThumbnailImage:(UIImage *)thumbnailImage
{
    _thumbnailImage = thumbnailImage;
    _imageView.image = thumbnailImage;
}

- (void)setLivePhotoBadgeImage:(UIImage *)livePhotoBadgeImage
{
    _livePhotoBadgeImage = livePhotoBadgeImage;
    _livePhotoBadgeImageView.image = livePhotoBadgeImage;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _imageView.image = nil;
    _livePhotoBadgeImageView.image = nil;
}

@end

