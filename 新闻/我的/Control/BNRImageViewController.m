//
//  BNRImageViewController.m
//  HomePwner
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright (c) 2019 apple. All rights reserved.
//

#import "BNRImageViewController.h"

@implementation BNRImageViewController

- (void)loadView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // cast the view to UIImageView so compiler knows it is OK to send it setImage
    UIImageView *imageView = (UIImageView*)self.view;
    imageView.image = self.image;
}

@end
