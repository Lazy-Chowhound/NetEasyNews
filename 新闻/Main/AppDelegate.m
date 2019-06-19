//
//  AppDelegate.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

@interface AppDelegate ()

@property (nonatomic , strong) NSArray *conversations;
@property (nonatomic , strong) TabbarViewController *tabbarMain;

@end

@implementation AppDelegate

- (NSArray *)conversations
{
    if (!_conversations) {
        _conversations = [NSArray array];
    }
    return _conversations;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.tabbarMain = [[TabbarViewController alloc]init];
    self.window.rootViewController = self.tabbarMain;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)selectTabbarIndex:(int)index
{
    [self.tabbarMain selectIndex:index];
}

@end
