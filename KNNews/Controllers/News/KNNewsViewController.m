//
//  KNNewsViewController.m
//  KNNews
//
//  Created by emper on 16/5/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KNNewsViewController.h"
#import "KNNewsTableViewController.h"

@interface KNNewsViewController ()

@end

@implementation KNNewsViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopMenuView];
    [self setupChildController];
    [self setupContentScrollView];
    [self setupChannelsEditView];
}

#pragma mark - 频道编辑视图
- (void)setupChannelsEditView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.channelMenuView.frame), self.view.frame.size.width, 0) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.collectionView.alpha = 0.98;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];

    [self.collectionView registerClass:[KNChannelCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - 初始化子视图
- (void)setupChildController {
    for (int i = 0; i < self.currentChannelsArray.count; i++) {
        KNNewsTableViewController *controller = [[KNNewsTableViewController alloc] init];
        [self addChildViewController:controller];
    }
}

#pragma mark - 初始化内容ScrollView
- (void)setupContentScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat top = self.channelMenuView.frame.size.height;
    CGFloat height = self.view.frame.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame) - top - self.tabBarController.tabBar.frame.size.height;
    scrollView.delegate = self;
    scrollView.frame = CGRectMake(0, top, self.view.frame.size.width, height);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.currentChannelsArray.count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    self.contentScrollView = scrollView;
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

#pragma mark - 初始化上方频道选择View
- (void)setupTopMenuView {
    KNTopMenuView *menuView = [[KNTopMenuView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 40)];
    menuView.delegate = self;
    [self.view addSubview:menuView];
    self.channelMenuView = menuView;
    self.channelMenuView.channelsArray = self.currentChannelsArray;
}

#pragma mark - 存储更新后的currentChannelsArray到偏好设置中
-(void)updateCurrentChannelsArrayToDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:self.currentChannelsArray forKey:@"currentChannelsArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 懒加载
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

#pragma mark - KNTopMenuViewDelegate
- (void)showOrhideAddChannelsView:(UIButton *)button {
    [self showOrHideChannelEditView:!button.selected];
    if (!button.selected && self.currentChannelsArray.count > 0) {
        [self.channelMenuView selectChannelButtonWithIndex:self.currentIndex];
        [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    }
}

- (void)chooseChannelWithIndex:(NSInteger)index {
    [self.contentScrollView setContentOffset:CGPointMake(self.contentScrollView.frame.size.width * index, 0) animated:YES];
}

- (void)showOrHideChannelEditView:(BOOL)value {
    if (value) {
        [UIView animateWithDuration:0.15 animations:^{
            self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.channelMenuView.frame), self.view.frame.size.width, self.view.frame.size.height);
            self.tabBarController.tabBar.hidden = YES;
        }];
    } else {
        [UIView animateWithDuration:0.15 animations:^{
            self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.channelMenuView.frame), self.view.frame.size.width, 0);
            self.tabBarController.tabBar.hidden = NO;
        }];
    }
    [self.channelMenuView showEditChannelView:value];
}

#pragma mark - UIScorllViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        NSInteger index = scrollView.contentOffset.x/self.contentScrollView.frame.size.width;
        self.currentIndex = index;
        
        KNNewsTableViewController *controller = self.childViewControllers[index];
        controller.channelName = self.currentChannelsArray[index];
        controller.view.frame = CGRectMake(scrollView.contentOffset.x, 0, self.contentScrollView.frame.size.width, self.contentScrollView.frame.size.height);
        if (!controller.view.superview) {
            [scrollView addSubview:controller.view];
        }
        [self.channelMenuView selectChannelButtonWithIndex:index];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.currentChannelsArray.count;
    } else {
        return self.remainChannelsArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KNChannelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.nameLabel.text = self.currentChannelsArray[indexPath.row];
        cell.deleteButton.hidden = NO;
        cell.delegate = self;
    } else {
        cell.nameLabel.text = self.remainChannelsArray[indexPath.row];
        cell.deleteButton.hidden = YES;
    }
    cell.indexPath = indexPath;
    return cell;
}


#pragma mark - UICollectionViewDelegate
//定义每个UICollectionView 的大小（返回CGSize：宽度和高度）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = (self.view.frame.size.width - 46)/4;
    return CGSizeMake(width, 40);
}
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 20, 15, 20);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}
//定义每个UICollectionView 横向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {//点击的是第一组的cell，跳转到相应的新闻频道
        [self.channelMenuView selectChannelButtonWithIndex:indexPath.row];
        [self showOrHideChannelEditView:NO];
    }else {//点击的是第二组的cell，新增自控制器
        [self.currentChannelsArray addObject:self.remainChannelsArray[indexPath.row]];
        [self.remainChannelsArray removeObjectAtIndex:indexPath.row];
        //新增自控制器
        KNNewsTableViewController *viewController = [[KNNewsTableViewController alloc] init];
        [self addChildViewController:viewController];
        //新增新闻频道
        [self.channelMenuView addAChannelButtonWithChannelName:self.currentChannelsArray.lastObject];
        self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width* self.currentChannelsArray.count, 0);
        [self.collectionView reloadData];
        [self updateCurrentChannelsArrayToDefaults];
    }
}

#pragma mark - KNChannelCollectionViewCellDelegate
- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex >= indexPath.row) {
        if (self.currentIndex > 0) {
            self.currentIndex = self.currentIndex -1;
        }
    }
    [self.remainChannelsArray addObject:self.currentChannelsArray[indexPath.row]];
    [self.currentChannelsArray removeObjectAtIndex:indexPath.row];
    [self.channelMenuView deleteChannelButtonWithIndex:indexPath.row];
    KNNewsTableViewController *controller = [self.childViewControllers objectAtIndex:indexPath.row];
    if (controller.view.superview) {
        [controller.view removeFromSuperview];
    }
    [self.childViewControllers[indexPath.row] removeFromParentViewController];
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width* self.currentChannelsArray.count, 0);
    [self.collectionView reloadData];
    [self updateCurrentChannelsArrayToDefaults];
    NSLog(@"number = %lu",(unsigned long)self.contentScrollView.subviews.count);
}
@end
