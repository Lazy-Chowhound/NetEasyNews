//
//  TopViewController.m
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "TopViewController.h"
#import "UIImageView+WebCache.h"
#import "TopData.h"


@interface TopViewController ()<UIScrollViewDelegate>

@property (nonatomic , weak) UIScrollView *scroll;
@property (nonatomic , weak) UILabel *titleLabel;
@property (nonatomic , weak) UILabel *countLabel;
@property (nonatomic , weak) UITextView *textview;
@property (nonatomic , strong) TopData *topdata;

@property (nonatomic , assign) int count;
@property (nonatomic , copy) NSString *setname;
@property (nonatomic , strong) NSMutableArray *totalArray;

@property (nonatomic , weak) UIImageView *imageV;

@end

@implementation TopViewController

-(NSMutableArray *)totalArray
{
    if (!_totalArray) {
        _totalArray = [NSMutableArray array];
    }
    return _totalArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initUI];
    
    [self initNetWork];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)initUI
{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 20)];
    scroll.backgroundColor = [UIColor blackColor];
    scroll.delegate = self;
    [self.view addSubview:scroll];
    self.scroll = scroll;
    
    //返回按钮
    UIButton *backbtn = [[UIButton alloc]init];
    backbtn.frame = CGRectMake(5, 25, 40, 40);
    [backbtn setBackgroundImage:[UIImage imageNamed:@"weather_back"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(5, SCREEN_HEIGHT - 70 - 49, SCREEN_WIDTH - 55, 20);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:19];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    //数量
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+5, titleLabel.frame.origin.y, 50, 15)];
    countLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:countLabel];
    self.countLabel = countLabel;
    
    //内容
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(titleLabel.frame), SCREEN_WIDTH - 15, 60)];
    textview.editable = NO;
    textview.font = [UIFont systemFontOfSize:14];
    textview.textAlignment = NSTextAlignmentLeft;
    textview.textColor = [UIColor whiteColor];
    textview.backgroundColor = [UIColor clearColor];
    textview.textColor = [UIColor whiteColor];
    [self.view addSubview:textview];
    self.textview = textview;

}

- (void)initNetWork
{
    IMP_BLOCK_SELF(TopViewController);
    
    [[BaseEngine shareEngine] runRequestWithPara:nil path:_url success:^(id responseObject) {
        
        block_self.count = [responseObject[@"imgsum"]intValue];
        block_self.setname = responseObject[@"setname"];
        
        NSArray *dataarray = [TopData objectArrayWithKeyValuesArray:responseObject[@"photos"]];
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        
        for (TopData *data in dataarray) {
            [statusFrameArray addObject:data];
        }
        [block_self.totalArray addObjectsFromArray:statusFrameArray];
        
        [block_self setLabel];
        [block_self setImageView];
        
    } failure:^(id error) {
        
    }];
}


-(void)setLabel
{
    //标题
    self.titleLabel.text = self.setname;
    //数量
    if (self.count > 1) {
        NSString *countNum = [NSString stringWithFormat:@"1/%d",self.count];
        self.countLabel.text = countNum;
    }
    //内容
    [self setContentWithIndex:0];
    
}

/** 添加内容 */
- (void)setContentWithIndex:(int)index
{
    NSString *content = [self.totalArray[index] note];
    NSString *contentTitle = [self.totalArray[index] imgtitle];
    if (content.length != 0) {
        self.textview.text = content;
    }else{
        self.textview.text = contentTitle;
    }
}

-(void)setImageView
{
    NSUInteger count = self.count;
    
    for (int i = 0; i < count; i++) {
        
        CGFloat imageH = self.scroll.frame.size.height - 100;
        CGFloat imageW = self.scroll.frame.size.width;
        CGFloat imageY = 0;
        CGFloat imageX = i * imageW;
        UIImageView *imaV = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
       
         // 图片的显示格式为合适大小
        imaV.contentMode= UIViewContentModeCenter;
        imaV.contentMode= UIViewContentModeScaleAspectFit;
        [self.scroll addSubview:imaV];
    }
    
    [self setImgWithIndex:0];
    
    self.scroll.contentOffset = CGPointZero;
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * count, 0);
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.pagingEnabled = YES;
}

/** 滚动完毕时调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.scroll.contentOffset.x / self.scroll.frame.size.width;
    // 添加图片
    [self setImgWithIndex:index];
    
    // 添加文字
    NSString *countNum = [NSString stringWithFormat:@"%d/%d",index+1,self.count];
    self.countLabel.text = countNum;
    
    // 添加内容
    [self setContentWithIndex:index];
}


- (void)setImgWithIndex:(int)i
{
    UIImageView *photoImgView = nil;
    if (i == 0) {
        photoImgView = self.scroll.subviews[i+2];
    }else{
        photoImgView = self.scroll.subviews[i];
    }
    
    NSURL *purl = [NSURL URLWithString:[self.totalArray[i] imgurl]];
    
    // 如果这个相框里还没有照片才添加
    if (photoImgView.image == nil) {
        [photoImgView sd_setImageWithURL:purl placeholderImage:nil];
        self.imageV = photoImgView;
    }
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

@end
