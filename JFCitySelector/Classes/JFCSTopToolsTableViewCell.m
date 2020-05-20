//
//  JFCSTopToolsTableViewCell.m
//  jfcityselector
//
//  Created by zhifenx on 2019/7/23.
//  Copyright © 2019 zhifenx. All rights reserved.
//

#import "JFCSTopToolsTableViewCell.h"

#import "JFCSPopularCitiesModel.h"
#import "JFCSFileManager.h"
@implementation JFCSTopToolsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0];
    }
    return self;
}
- (void)setupData:(NSArray <NSString *>*)dataArr{
    self.buttonArr = [NSMutableArray new];
    [dataArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [self createButton:idx title:obj isLocation:NO];
        
    }];
}
- (void)setupData:(NSArray <NSString *>*)dataArr isLocation:(BOOL)isLocation{
    self.buttonArr = [NSMutableArray new];
    [dataArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0){
            [self createButton:idx title:obj isLocation:isLocation];
        }else{
            [self createButton:idx title:obj isLocation:NO];
        }
        
    }];
}


- (void)createButton:(NSInteger)index title:(NSString *)title isLocation:(BOOL)isLocation {
    //TODO: 判断是否定位
    NSInteger indexX = index % 3;
    NSInteger indexY = index / 3;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonIntervalH = 16;
    CGFloat buttonIntervalV = 10;
    CGFloat buttonW = ([UIScreen mainScreen].bounds.size.width - buttonIntervalH * 4) / 3 - 5;
    CGFloat buttonH = 36;
    CGFloat buttonX = buttonIntervalH * (indexX + 1) + indexX * buttonW;
    CGFloat buttonY = buttonIntervalV * (indexY + 1) + indexY * buttonH;
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    [button setTag:index];
    [button.layer setCornerRadius:3];
    [button setTitle:title forState:UIControlStateNormal];

    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button .titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    if (isLocation){
        [button setImage:[JFCSFileManager getImageWithName:@"icon_location"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 4);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2);
    }
    
    
    [self.contentView addSubview:button];
    [self.buttonArr addObject:button];
}

- (void)buttonAction:(UIButton *)sender {
    if (self.selectCityBlock) {
        self.selectCityBlock(sender.tag);
    }
}

- (void)topToolsCellSelectCityBlock:(topToolsCellSelectCityBlock)block {
    if (block) {
        self.selectCityBlock = block;
    }
}

@end
