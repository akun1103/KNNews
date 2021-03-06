//
//  KNTopMenuView.m
//  KNNews
//
//  Created by emper on 16/5/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KNTopMenuView.h"

#define addChannelButtonWidth 30
#define sliderViewWidth 20
#define tittleNormalFont 15
#define tittleSelectedFont 17

@implementation KNTopMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}
#pragma mark --channelArray的setter方法
- (void)setChannelsArray:(NSArray *)channelsArray {
    _channelsArray = channelsArray;
    CGFloat buttonWidth = self.scrollView.frame.size.width/5;
    self.scrollView.contentSize = CGSizeMake(buttonWidth * channelsArray.count, 0);
    for (NSInteger i = 0; i < channelsArray.count; i++) {
        UIButton *button = [self createChannelButton];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:tittleNormalFont]];
        [button addTarget:self action:@selector(channelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button layoutIfNeeded];
        [button setFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, self.frame.size.height)];
        [button setTitle:channelsArray[i] forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
    }
    //默认选中第一个频道
    [self channelButtonClicked:self.scrollView.subviews[1]];
}

#pragma mark --初始化子控件
- (void)initialization {
    self.alpha = 0.9;
    self.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    [self createScrollView];
    
    [self createIndicatorView];
    
    [self createAddChannelButton];
    
    [self createSliderView];
}

- (void)createScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, WIDTH_SCREEN - addChannelButtonWidth, self.frame.size.height);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    [self addSubview:self.scrollView];
}

- (void)createIndicatorView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, self.frame.size.height - 2, self.scrollView.frame.size.width/5, 2);
    view.backgroundColor = DEFAULT_TABBAR_COLOR;
    self.indicatorView = view;
    [self.scrollView insertSubview:self.indicatorView atIndex:0];
}

- (void)createAddChannelButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"home_header_add_slim"] forState:UIControlStateNormal];
    button.frame = CGRectMake(WIDTH_SCREEN - addChannelButtonWidth, 0, addChannelButtonWidth, self.frame.size.height);
    [button addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.addChannelButton = button;
    [self addSubview:self.addChannelButton];
}

- (void)createSliderView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(WIDTH_SCREEN - addChannelButtonWidth - sliderViewWidth, 0, sliderViewWidth, self.frame.size.height);
    imageView.image = [UIImage imageNamed:@"slidetab_mask"];
    imageView.alpha = 0.8;
    [self addSubview:imageView];
}

- (UIButton *)createChannelButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:tittleNormalFont]];
    [button addTarget:self action:@selector(channelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button layoutIfNeeded];
    return button;
}

- (void)channelButtonClicked:(UIButton *)button {
    self.currentSelectedButton.titleLabel.font = [UIFont systemFontOfSize:tittleNormalFont];
    [self.currentSelectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.currentSelectedButton = button;
    
    CGFloat newOffsetX = button.center.x - [UIScreen mainScreen].bounds.size.width*0.5;

    if (newOffsetX > self.scrollView.contentSize.width - self.scrollView.frame.size.width) {
        newOffsetX = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    }
    if (newOffsetX < 0) {
        newOffsetX = 0;
    }
    [button.titleLabel setFont:[UIFont systemFontOfSize:tittleSelectedFont]];
    [button setTitleColor:DEFAULT_TABBAR_COLOR forState:UIControlStateNormal];
    [button layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(newOffsetX, 0)];
        CGPoint senderTittleNewPoint = [button.titleLabel.superview convertPoint:button.titleLabel.frame.origin toView:self.scrollView];
        //indicatorView宽度会比titleLabel宽10，centerX与titleLabel相同
        self.indicatorView.frame = CGRectMake(senderTittleNewPoint.x - 5, self.frame.size.height - 2, button.titleLabel.frame.size.width + 10, 2);
    }];
    
    NSInteger index = [self.scrollView.subviews indexOfObject:button];
    if ([self.delegate respondsToSelector:@selector(chooseChannelWithIndex:)]) {
        [self.delegate chooseChannelWithIndex:index - 1];
    }
}

#pragma mark 选中某个ChannelButton
- (void)selectChannelButtonWithIndex:(NSInteger)index {
    [self channelButtonClicked:self.scrollView.subviews[index + 1]];
}

#pragma mark 删除某个ChannelButton
- (void)deleteChannelButtonWithIndex:(NSInteger)index {
    //删除index对应的button，
    [self.scrollView.subviews[index + 1] removeFromSuperview];
    //后面的button的x向左移动buuton宽度的距离
    for (NSInteger i = index + 1; i < self.scrollView.subviews.count; i++) {
        UIButton *button = self.scrollView.subviews[i];
        CGRect buttonFrame = button.frame;
        button.frame = CGRectMake(buttonFrame.origin.x - button.frame.size.width, buttonFrame.origin.y, buttonFrame.size.width, buttonFrame.size.height);
    }
    //将scrollView的contentSize减小一个buuton的宽度
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width - self.scrollView.frame.size.width/5, 0);
}

#pragma mark 添加频道：增加scrollView的contensize，然后在最后添加一个channelButton
- (void)addAChannelButtonWithChannelName:(NSString *)channelName {
    CGFloat buttonWidth = self.scrollView.frame.size.width/5;
    UIButton *button = [self createChannelButton];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + buttonWidth, 0);
    button.frame = CGRectMake(self.scrollView.contentSize.width - buttonWidth , 0, buttonWidth, self.frame.size.height);
    [button setTitle:channelName forState:UIControlStateNormal];
    [self.scrollView addSubview:button];
}

- (void)addButtonClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(showOrhideAddChannelsView:)]) {
        [self.delegate showOrhideAddChannelsView:button];
    }
}

- (void)showEditChannelView:(BOOL)value {
    if (value) {
        self.addChannelButton.selected = YES;
        self.indicatorView.hidden = YES;
        self.scrollView.hidden = YES;
    } else {
        self.addChannelButton.selected = NO;
        self.indicatorView.hidden = NO;
        self.scrollView.hidden = NO;
        if (self.scrollView.subviews.count == 1) {
            self.indicatorView.hidden = YES;
        } else {
            self.indicatorView.hidden = NO;
        }
    }
}
@end
