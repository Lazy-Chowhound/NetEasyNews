//
//  ImagesCell.m
//  新闻
//
//  Created by 李浩铭 on 19/6/10.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "ImagesCell.h"
#import "UIImageView+WebCache.h"
#import "DataModel.h"


@implementation ImagesCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"imagescell";
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    ImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, SCREEN_WIDTH-16, 20)];
        if (SCREEN_WIDTH == 320) {
            titleL.font = [UIFont systemFontOfSize:15];
        }else{
            titleL.font = [UIFont systemFontOfSize:16];
        }
        [self addSubview:titleL];
        self.titleL = titleL;
        
        CGFloat imageY = CGRectGetMaxY(titleL.frame)+10;
        CGFloat imageW = (SCREEN_WIDTH-40)/3;
        CGFloat imageH = 0.7*imageW;
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, imageY, imageW, imageH)];
        imageview.backgroundColor = [UIColor grayColor];
        [self addSubview:imageview];
        self.image1 = imageview;
        
        UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+10, imageY, imageW, imageH)];
        image2.backgroundColor = [UIColor grayColor];
        [self addSubview:image2];
        self.image2 = image2;
        
        UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image2.frame)+10, imageY, imageW, imageH)];
        image3.backgroundColor = [UIColor grayColor];
        [self addSubview:image3];
        self.image3 = image3;
        
        CGFloat x = 10;
        CGFloat y = CGRectGetMaxY(self.image1.frame)+10;
        CGFloat w = 100;
        CGFloat h = 15;
        UILabel *replyL = [[UILabel alloc]init];
        replyL.frame = CGRectMake(x, y, w, h);
        replyL.textAlignment = NSTextAlignmentCenter;
        replyL.font = [UIFont systemFontOfSize:10];
        replyL.textColor = [UIColor darkGrayColor];
        [self addSubview:replyL];
        self.lblReply = replyL;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(replyL.frame) + 10, SCREEN_WIDTH - 20, 1)];
        line.backgroundColor = HEXColor(@"eeeeee");
        [self addSubview:line];
    }
    return self;
}


- (void)setDataModel:(DataModel *)dataModel
{
    _dataModel = dataModel;
    
    [self.image1 sd_setImageWithURL:[NSURL URLWithString:self.dataModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleL.text = self.dataModel.title;

    CGFloat count =  [self.dataModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    self.lblReply.text = displayCount;
    
    self.lblReply.width = [self.lblReply.text sizeWithFont:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(200, MAXFLOAT)].size.width;
    self.lblReply.width += 10;
    self.lblReply.originX = SCREEN_WIDTH - 10 - self.lblReply.width;
    
    [self.lblReply.layer setBorderWidth:1];
    [self.lblReply.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.lblReply.layer setCornerRadius:5];
    self.lblReply.clipsToBounds = YES;


    if (self.dataModel.imgextra.count == 2) {

        [self.image2 sd_setImageWithURL:[NSURL URLWithString:self.dataModel.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.image3 sd_setImageWithURL:[NSURL URLWithString:self.dataModel.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    
}

@end

