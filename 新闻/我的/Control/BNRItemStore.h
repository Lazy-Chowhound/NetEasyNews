//
//  BNRItemStore.h
//  HomePwner
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright (c) 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

// accessor to all items in store
@property (nonatomic, readonly) NSArray* allItems;

// accessor to singleton
+ (instancetype)sharedStore;

- (NSArray *)allAssetTypes;
- (BNRItem *)createItem;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
- (void)removeItem:(BNRItem*)item;
- (BOOL)saveChanges;

@end
