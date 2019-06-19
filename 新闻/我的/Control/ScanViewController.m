//
//  ScanViewController.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>


#define WIDTH [UIScreen mainScreen].bounds.size.width

#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong)AVCaptureSession * session;

@property (nonatomic,strong)UIView * scansoinView;

@property (nonatomic,strong)UIImageView * distinguishView;

@property (nonatomic,strong)UILabel * resultLab;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

-(void)createUI{
    _resultLab = [[UILabel alloc]initWithFrame:CGRectMake(30, HEIGHT-100, WIDTH-60, 64)];
    _resultLab.backgroundColor = [UIColor blackColor];
    _resultLab.text = @"扫描结果";//
    _resultLab.textAlignment = NSTextAlignmentCenter;
    _resultLab.textColor = [UIColor whiteColor];
    _resultLab.numberOfLines = 0;
    
    [self.view addSubview:_resultLab];
    [self createScansionView];
}

#pragma mark 创建扫描页面
-(void)createScansionView{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"获取权限" message:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“XXXX”打开相机访问权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    _scansoinView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-184)];
    _scansoinView.backgroundColor = [UIColor blackColor];
    AVCaptureDevice * captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput * deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:deviceInput]) {
        [_session addInput:deviceInput];
    }
    if ([_session canAddOutput:output]) {
        [_session addOutput:output];
    }
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    AVCaptureVideoPreviewLayer * previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = _scansoinView.layer.bounds;
    [_scansoinView.layer insertSublayer:previewLayer atIndex:0];
    UILabel * xianLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    xianLab.backgroundColor = [UIColor redColor];
    [_scansoinView addSubview:xianLab];
    [UIView animateWithDuration:2.5 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
        xianLab.frame = CGRectMake(0, HEIGHT-184, WIDTH, 1);
    } completion:nil];
    
    [self.view addSubview:_scansoinView];
    [_session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    [_session stopRunning];
    AVMetadataMachineReadableCodeObject * codeOBJ = metadataObjects[0];
    _resultLab.text = [NSString stringWithFormat:@"扫描结果:%@",codeOBJ.stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
