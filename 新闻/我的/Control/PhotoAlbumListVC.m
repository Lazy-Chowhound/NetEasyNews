//
//  PhotoAlbumListVC.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/12.
//  Copyright © 2019 apple. All rights reserved.
//
#import "PhotoAlbumListVC.h"
#import <Photos/Photos.h>
#import "AssetGridVC.h"

typedef NS_ENUM(NSUInteger, RowsInSection) {
    allPhotos = 0,
    smartAlbums,
    userCollections,
};

static NSString * const CellID = @"CellID";

@interface PhotoAlbumListVC () <PHPhotoLibraryChangeObserver>

@property (nonatomic, strong) PHFetchResult<PHAsset *> *allPhotos;
@property (nonatomic, strong) PHFetchResult<PHAssetCollection *> *smartAlbums;
@property (nonatomic, strong) PHFetchResult<PHAssetCollection *> *userCollections;
@property (nonatomic, strong) NSArray *sectionLocalizedTitles;

@end

@implementation PhotoAlbumListVC

- (void)dealloc
{
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData
{
    [self fetchAssetCollection];
    _sectionLocalizedTitles = @[@"", @"Smart Albums", @"Albums"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)fetchAssetCollection
{
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    // 按创建时间升序
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    // 获取所有照片（按创建时间升序）
    _allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    // 获取所有智能相册
    _smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 获取所有用户创建相册
    _userCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case allPhotos:
            return 1;
            break;
        case smartAlbums:
            return _smartAlbums.count;
            break;
        case userCollections:
            return _userCollections.count;
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case allPhotos:
        {
            cell.textLabel.text = @"All Photos";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd", _allPhotos.count];
            break;
        }
        case smartAlbums:
        {
            PHAssetCollection *collection = [_smartAlbums objectAtIndex:indexPath.row];
            cell.textLabel.text = collection.localizedTitle;
            break;
        }
        case userCollections:
        {
            PHAssetCollection *collection = [_userCollections objectAtIndex:indexPath.row];
            cell.textLabel.text = collection.localizedTitle;
            break;
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionLocalizedTitles[section];
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    AssetGridVC *vc = [[AssetGridVC alloc] initWithCollectionViewLayout:layout];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.title = cell.textLabel.text;
    PHAssetCollection *collection = nil;
    if (indexPath.section == allPhotos) {
        vc.fetchResult = _allPhotos;
    }
    else if (indexPath.section == smartAlbums) {
        collection = [_smartAlbums objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == userCollections) {
        collection = [_userCollections objectAtIndex:indexPath.row];
    }
    vc.assetCollection = collection;
    vc.fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - PHPhotoLibraryChangeObserver -
- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self fetchAssetCollection];
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
