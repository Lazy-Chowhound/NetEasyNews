//
//  TabbarViewController.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "TabbarViewController.h"
#import "NavigationController.h"
#import "VideoViewController.h"
#import "MeViewController.h"
#import "SCNavTabBarController.h"
#import "TabbarView.h"

@interface TabbarViewController ()
@property (nonatomic , strong) TabbarView *tabbar;

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabbar];
    [self initControl];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if(![child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
}

- (void)selectIndex:(int)index
{
    [self.tabbar selectIndex:index];
}

-(void)initTabbar
{
    IMP_BLOCK_SELF(TabbarViewController);
    TabbarView *tabbar = [[TabbarView alloc]init];
    tabbar.frame = self.tabBar.bounds;
    tabbar.btnSelectBlock = ^(int to){
        block_self.selectedIndex = to;
    };
    [self.tabBar addSubview:tabbar];
    self.tabbar = tabbar;
}

- (void)initControl
{
    SCNavTabBarController  *new = [[SCNavTabBarController alloc]init];
    [self setupChildViewController:new title:@"新闻" imageName:@"tabbar_news" selectedImage:@"tabbar_news_hl"];
    
    VideoViewController *video = [[VideoViewController alloc]init];
    [self setupChildViewController:video title:@"视频" imageName:@"tabbar_video" selectedImage:@"tabbar_video_hl"];

    MeViewController *me = [[MeViewController alloc]init];
    [self setupChildViewController:me title:@"我的" imageName:@"tabbar_setting" selectedImage:@"tabbar_setting_hl"];

}


-(void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage
{
    //设置控制器属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //包装一个导航控制器
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    [self.tabbar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
