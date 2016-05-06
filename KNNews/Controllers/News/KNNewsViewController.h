//
//  KNNewsViewController.h
//  KNNews
//
//  Created by emper on 16/5/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KNViewController.h"
#import "KNTopMenuView.h"
#import "KNChannelCollectionViewCell.h"

@interface KNNewsViewController : KNViewController<KNTopMenuViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,KNChannelCollectionViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *currentChannelsArray;
@property (nonatomic, strong) NSMutableArray *remainChannelsArray;
@property (nonatomic, strong) NSMutableArray *allChannelsArray;
@property (nonatomic, strong) NSMutableDictionary *channelsURLDictionary;
@property (nonatomic, weak) KNTopMenuView *channelMenuView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger currentIndex;

@end
