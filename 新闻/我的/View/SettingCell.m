//
//  SettingCell.m
//  新闻
//
//  Created by 李浩铭 on 2019/6/13.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"

@interface SettingCell()
@property(nonatomic,strong)UIImageView *myarrow;
@property(nonatomic,strong)UISwitch *myswitch;
@property(nonatomic,strong)UILabel *mylabel;

@end

@implementation SettingCell

-(UIImageView *)myarrow
{
    if (_myarrow == nil) {
        _myarrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _myarrow;
}

-(UISwitch *)myswitch
{
    if (_myswitch == nil) {
        _myswitch = [[UISwitch alloc]init];
        [_myswitch addTarget:self action:@selector(switchchange) forControlEvents:UIControlEventValueChanged];
    }
    return _myswitch;
    
}

-(UILabel *)mylabel
{
    if (_mylabel == nil) {
        _mylabel = [[UILabel alloc]init];
        _mylabel.bounds = CGRectMake(0, 0, 50, 20);
    }
    return _mylabel;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:237/255.0 green:233/255.0 blue:218/255.0 alpha:1];
        self.selectedBackgroundView = view;
    }
    return self;
}

//返回一个cell
+(instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"setting";
    SettingCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}


//返回cell的数据

-(void)setItem:(SettingItem *)item
{
    _item = item;
    
    //设置cell
    [self setupCell];
    //设置cell右边内容
    [self setupRight];
    
}

-(void)setupRight
{
    if ([self.item isKindOfClass:[SettingArrowItem class]]) //箭头
    {
        self.accessoryView = self.myarrow;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    }else
    {
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}

-(void)setupCell
{
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    
    self.textLabel.text = self.item.title;
    self.detailTextLabel.text = self.item.subtitle;
    self.detailTextLabel.textColor = [UIColor redColor];
}

@end
