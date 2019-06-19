//
//  GYPlayer.m
//  新闻
//
//  Created by 李浩铭 on 19/6/11.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "GYPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "GYHCircleLoadingView.h"

@interface GYPlayer ()

@property (nonatomic, strong) AVPlayerItem * playerItem;
@property (nonatomic, strong) AVPlayerLayer * playerLayer;
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) GYHCircleLoadingView * circleLoadingV;

@property (nonatomic, strong) UIView * bottomView;       //整个view
@property (nonatomic, strong) UILabel * lbTitle;         //视频标题
@property (nonatomic, strong) UIImageView * imgBgTop;    //视频标题背景

@property (nonatomic, strong) UIView * bottomBar;        //底部工具栏
@property (nonatomic, strong) UIImageView * imgBgBottom; //视频底部背景
@property (nonatomic, strong) UIButton * btnPlayOrPause; //播放暂停
@property (nonatomic, strong) UIButton * btnFullScreen;  //全屏按钮

@property (nonatomic) BOOL isFullScreen;

@end

@implementation GYPlayer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {//黑块区域
        
        self.backgroundColor = [UIColor blackColor];
        
        //监听屏幕改变
        UIDevice *device = [UIDevice currentDevice];
        [device beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:device];
        
        self.circleLoadingV = [[GYHCircleLoadingView alloc]initWithViewFrame:CGRectMake(self.width/2-20, self.height/2-20, 40, 40)];
        
        [self addSubview:self.circleLoadingV];
        
    }
    return self;
}

- (void)setMp4_url:(NSString *)mp4_url {
    _mp4_url = mp4_url;
    [self.layer addSublayer:self.playerLayer];
    [self insertSubview:self.bottomView aboveSubview:self];
    [self insertSubview:self.circleLoadingV aboveSubview:self.bottomView];
    [self.circleLoadingV startAnimating];
    [self.player play];

}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.lbTitle.text = _title;
}

#pragma mark - action
//添加kvo noti
- (void)addObserverAndNotification {
    //监控状态属性 AVPlayerStatusUnknown,AVPlayerStatusReadyToPlay,AVPlayerStatusFailed
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //加载进度
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

//kvo监听播放器状态
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay){
            [self.circleLoadingV stopAnimating];
        } else if (status == AVPlayerStatusFailed){
        } else if (status == AVPlayerStatusUnknown){
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {

    }
}

//播放暂停
- (void)playOrPause:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.btnPlayOrPause setImage:[UIImage imageNamed:@"video_pause.png"] forState:UIControlStateNormal];
        [self.player play];
    } else {
        [self.btnPlayOrPause setImage:[UIImage imageNamed:@"video_play.png"] forState:UIControlStateNormal];
        [self.player pause];
    }
}

//全屏不全屏
- (void)fullScreen:(UIButton *)btn {
    if (self.isFullScreen) {
        [self.btnFullScreen setImage:[UIImage imageNamed:@"sc_video_play_ns_enter_fs_btn.png"] forState:UIControlStateNormal];
    } else {
        [self.btnFullScreen setImage:[UIImage imageNamed:@"sc_video_play_fs_enter_ns_btn.png"] forState:UIControlStateNormal];
    }
}

- (void)removePlayer {
    if (self.superview) {
        [self.player pause];
        [self.player.currentItem cancelPendingSeeks];
        [self.player.currentItem.asset cancelLoading];
        [self.playerItem removeObserver:self forKeyPath:@"status"];
        [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self removeFromSuperview];
    }
}

- (void)dealloc {
    [self removePlayer];
}

#pragma mark - lazy

- (AVPlayer *)player {
    if (!_player) {
        self.playerItem = [self getAVPlayItem];
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];
        [self addObserverAndNotification];
    }
    return _player;
}

- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.frame = self.bounds;
        _playerLayer.backgroundColor = [UIColor clearColor].CGColor;
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;    //视频填充模式
    }
    return _playerLayer;
}

//获取url是网络的还是本地的
- (AVPlayerItem *)getAVPlayItem{
    if ([self.mp4_url rangeOfString:@"http"].location != NSNotFound) {
        AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:[NSURL URLWithString:[self.mp4_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        return playerItem;
    }else{
        AVAsset *movieAsset  = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:self.mp4_url] options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        return playerItem;
    }
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
        
        self.imgBgTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        self.imgBgTop.image = [UIImage imageNamed:@"top_shadow.png"];
        [_bottomView addSubview:self.imgBgTop];
        
        self.lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 40)];
        self.lbTitle.font = [UIFont systemFontOfSize:16];
        self.lbTitle.numberOfLines = 0;
        self.lbTitle.textColor = HEXColor(@"ffffff");
        [_bottomView addSubview:self.lbTitle];

        self.bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 37, SCREEN_WIDTH, 37)];
        [_bottomView addSubview:self.bottomBar];

        self.imgBgBottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 37)];
        self.imgBgBottom.image = [UIImage imageNamed:@"bottom_shadow.png"];
        [self.bottomBar addSubview:self.imgBgBottom];
        
        self.btnPlayOrPause = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 17, 17)];
        [self.btnPlayOrPause setImage:[UIImage imageNamed:@"video_pause.png"] forState:UIControlStateNormal];
        [self.btnPlayOrPause addTarget:self action:@selector(playOrPause:) forControlEvents:UIControlEventTouchUpInside];
        self.btnPlayOrPause.selected = YES;
        [self.bottomBar addSubview:self.btnPlayOrPause];
        
        [self addSubview:_bottomView];
    }
    return _bottomView;
}

@end
