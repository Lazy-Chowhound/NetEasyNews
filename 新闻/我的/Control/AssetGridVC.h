//
//  AssetGridVC.h
//  新闻
//
//  Created by 李浩铭 on 2019/6/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface AssetGridVC : UICollectionViewController

@property (nonatomic, strong) PHFetchResult<PHAsset *> *fetchResult;
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end

NS_ASSUME_NONNULL_END
