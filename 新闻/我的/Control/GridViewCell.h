//
//  GridViewCell.h
//  新闻
//
//  Created by 李浩铭 on 2019/6/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GridViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *representedAssetIdentifier;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) UIImage *livePhotoBadgeImage;

@end

NS_ASSUME_NONNULL_END
