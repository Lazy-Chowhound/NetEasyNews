//
//  BNRImageStore.h
//  HomePwner
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright (c) 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject
{
}

+ (instancetype)sharedStore;

// add image
- (void)setImage:(UIImage*)image forKey:(NSString*)key;
// get image
- (UIImage*)imageForKey:(NSString*)key;
// delete iamge
- (void)deleteImageForKey:(NSString*)key;


@end
