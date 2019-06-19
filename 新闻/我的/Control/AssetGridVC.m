//
//  AssetGridVC.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AssetGridVC.h"
#import "GridViewCell.h"
#import <PhotosUI/PhotosUI.h>

#define SCR_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCR_HEIGHT  [[UIScreen mainScreen] bounds].size.height

@interface AssetGridVC ()<UICollectionViewDelegateFlowLayout>
{
    CGSize thumbnailSize;
    CGRect previousPreheatRect;
}

@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property (nonatomic, strong) PHImageRequestOptions *requestOption;

@end

@implementation AssetGridVC

static NSString * const reuseIdentifier = @"Cell";

- (void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initView];
    [self.collectionView registerClass:[GridViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    CGFloat item_WH = (SCR_WIDTH-20.f-2.f*3)/4.f;
    thumbnailSize = CGSizeMake(item_WH * scale, item_WH * scale);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateCachedAssets];
}

- (void)initData
{
    if (!_fetchResult) {
        PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
        allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        _fetchResult = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    }
    
    _imageManager = [[PHCachingImageManager alloc] init];
    _requestOption = [[PHImageRequestOptions alloc] init];
    _requestOption.resizeMode = PHImageRequestOptionsResizeModeExact;
    _requestOption = nil;
    
    [self resetCachedAssets];
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];;
}

- (void)resetCachedAssets
{
    [_imageManager stopCachingImagesForAllAssets];
    previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets
{
    if (!self.isViewLoaded || self.view.window == nil) {
        return;
    }
    
    CGRect visibleRect = CGRectMake(0.f, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    CGRect preheatRect = CGRectInset(visibleRect, 0, -0.5*visibleRect.size.height);
    
    CGFloat delta = fabs(CGRectGetMidY(preheatRect) - CGRectGetMidY(previousPreheatRect));
    if (delta > self.view.bounds.size.height / 3.f) {
        [self computeDifferenceBetweenRect:previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            [self imageManagerStopCachingImagesWithRect:removedRect];
        } addedHandler:^(CGRect addedRect) {
            [self imageManagerStartCachingImagesWithRect:addedRect];
        }];
        previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler
{
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        //添加 向下滑动时 newRect 除去与 oldRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        //添加 向上滑动时 newRect 除去与 oldRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        //移除 向上滑动时 oldRect 除去与 newRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        //移除 向下滑动时 oldRect 除去与 newRect 相交部分的区域（即：屏幕外顶部的预热区域）
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    }
    else {
        //当 oldRect 与 newRect 没有相交区域时
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (void)imageManagerStartCachingImagesWithRect:(CGRect)rect
{
    NSMutableArray<PHAsset *> *addAssets = [self indexPathsForElementsWithRect:rect];
    [_imageManager startCachingImagesForAssets:addAssets targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption];
}

- (void)imageManagerStopCachingImagesWithRect:(CGRect)rect
{
    NSMutableArray<PHAsset *> *removeAssets = [self indexPathsForElementsWithRect:rect];
    [_imageManager stopCachingImagesForAssets:removeAssets targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption];
}

- (NSMutableArray<PHAsset *> *)indexPathsForElementsWithRect:(CGRect)rect
{
    UICollectionViewLayout *layout = self.collectionView.collectionViewLayout;
    NSArray<__kindof UICollectionViewLayoutAttributes *> *layoutAttributes = [layout layoutAttributesForElementsInRect:rect];
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    for (__kindof UICollectionViewLayoutAttributes *layoutAttr in layoutAttributes) {
        NSIndexPath *indexPath = layoutAttr.indexPath;
        PHAsset *asset = [_fetchResult objectAtIndex:indexPath.item];
        [assets addObject:asset];
    }
    return assets;
}

#pragma mark - UIScrollViewDelegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateCachedAssets];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    PHAsset *asset = [_fetchResult objectAtIndex:indexPath.item];
    if (@available(iOS 9.1, *)) {
        if (asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
            cell.livePhotoBadgeImage = [PHLivePhotoView livePhotoBadgeImageWithOptions:PHLivePhotoBadgeOptionsOverContent];
        }
    }
    
    cell.representedAssetIdentifier = asset.localIdentifier;
    
    // targetSize 是以像素计量的，所以需要实际的 size * UIScreen.mainScreen.scale
    [_imageManager requestImageForAsset:asset targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:_requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        // 当 resultHandler 被调用时，cell可能已被回收，所以此处加个判断条件
        if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
            cell.thumbnailImage = result;
        }
    }];
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat item_WH = (SCR_WIDTH-20.f-2.f*3)/4.f;
    return CGSizeMake(item_WH, item_WH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10.f, 10.f, 10.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
