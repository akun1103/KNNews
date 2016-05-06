//
//  KNTopMenuView.h
//  KNNews
//
//  Created by emper on 16/5/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KNTopMenuViewDelegate <NSObject>

@optional

- (void)showOrhideAddChannelsView:(UIButton *)button;
- (void)chooseChannelWithIndex:(NSInteger)index;

@end

@interface KNTopMenuView : UIView

@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIButton *currentSelectedButton;
@property (nonatomic, weak) UIButton *addChannelButton;
@property (nonatomic, copy) NSArray *channelsArray;

@property (nonatomic, weak) id<KNTopMenuViewDelegate> delegate;

- (void)selectChannelButtonWithIndex:(NSInteger)index;
- (void)deleteChannelButtonWithIndex:(NSInteger)index;
- (void)addAChannelButtonWithChannelName:(NSString *)channelName;
- (void)showEditChannelView:(BOOL)value;
@end
