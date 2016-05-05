//
//  KNNewsViewController.m
//  KNNews
//
//  Created by emper on 16/5/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KNNewsViewController.h"
#import "KNTopMenuView.h"

@interface KNNewsViewController ()<KNTopMenuViewDelegate>

@end

@implementation KNNewsViewController

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    [self setupTopMenuView];
}
#pragma mark --初始化上方频道选择View
- (void)setupTopMenuView {
    CGFloat top = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    KNTopMenuView *menuView = [[KNTopMenuView alloc] initWithFrame:CGRectMake(0, top, WIDTH_SCREEN, 40)];
    menuView.channelsArray = self.currentChannelsArray;
    menuView.delegate = self;
    [self.view addSubview:menuView];
}

#pragma mark --存储更新后的currentChannelsArray到偏好设置中
-(void)updateCurrentChannelsArrayToDefaults{
    [[NSUserDefaults standardUserDefaults] setObject:self.currentChannelsArray forKey:@"currentChannelsArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark --懒加载
- (NSMutableArray *)allChannelsArray {
    if (!_allChannelsArray) {
        _allChannelsArray = [NSMutableArray array];
        NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"allChannelsArray"];
        [_allChannelsArray addObjectsFromArray:tempArray];
        if (_allChannelsArray.count == 0) {
            [_allChannelsArray addObjectsFromArray:@[@"国内", @"国际", @"娱乐", @"互联网", @"体育", @"财经", @"科技", @"汽车", @"军事", @"理财", @"经济", @"房产", @"国际足球", @"国内足球", @"综合体育", @"电影", @"电视", @"游戏", @"教育", @"美容", @"情感",@"养生", @"数码", @"电脑", @"科普", @"社会", @"台湾", @"港澳"]];
            [[NSUserDefaults standardUserDefaults] setObject:_allChannelsArray forKey:@"allChannelsArray"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return _allChannelsArray;
}
- (NSMutableArray *)currentChannelsArray {
    if (!_currentChannelsArray) {
        _currentChannelsArray = [NSMutableArray array];
        NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"currentChannelsArray"];
        [_currentChannelsArray addObjectsFromArray:array];
        if (_currentChannelsArray.count == 0) {
            [_currentChannelsArray addObjectsFromArray:@[@"国内",@"体育",@"娱乐",@"汽车",@"互联网",@"财经"]];
            [self updateCurrentChannelsArrayToDefaults];
        }
    }
    return _currentChannelsArray;
}

- (NSMutableArray *)remainChannelsArray {
    if (!_remainChannelsArray) {
        _remainChannelsArray = [NSMutableArray array];
        [_remainChannelsArray addObjectsFromArray:self.allChannelsArray];
        [_remainChannelsArray removeObjectsInArray:self.currentChannelsArray];
    }
    return _remainChannelsArray;
}

#pragma mark --KNTopMenuViewDelegate

- (void)showOrhideAddChannelsView:(UIButton *)button {

}

- (void)chooseChannelWithIndex:(NSInteger)index {

}
@end
