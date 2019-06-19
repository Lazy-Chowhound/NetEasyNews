//
//  DetailViewController.m
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "DetailWebViewController.h"
#import "DetailWebModel.h"
#import "DetailImageWebModel.h"
#import "NSDate+gyh.h"

@interface DetailWebViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) DetailWebModel *detailModel;
@property (nonatomic , weak) UIWebView *webView;
@property (nonatomic , copy) NSString *url;
@end

@implementation DetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

- (void)setupUI
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 54, 44)];
    [btn setImage:[UIImage imageNamed:@"night_icon_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineV];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.backgroundColor = [UIColor whiteColor];
    webView.originY = 64;
    webView.height = SCREEN_HEIGHT - 64;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)setupData
{
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.dataModel.docid];
    self.url = url;
    IMP_BLOCK_SELF(DetailWebViewController);
    [[BaseEngine shareEngine] runRequestWithPara:nil path:url success:^(id responseObject) {
        
        block_self.detailModel = [DetailWebModel detailWithDict:responseObject[block_self.dataModel.docid]];
        [block_self showInWebView];
        
    } failure:^(id error) {
        
    }];
}


- (void)showInWebView
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"Detail.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
    
}

- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    // 遍历img
    for (DetailImageWebModel *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end
