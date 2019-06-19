
// 顶部导航栏
//

#import <UIKit/UIKit.h>

@class SCNavTabBar;

@interface SCNavTabBarController : UIViewController

@property (nonatomic, assign) BOOL scrollAnimation;
@property (nonatomic, assign) BOOL mainViewBounces;            

@property (nonatomic, strong)NSArray *subViewControllers;

@property (nonatomic, strong)UIColor  *navTabBarColor;
@property (nonatomic, strong)UIColor  *navTabBarLineColor;

@end


