//
//  KNInfoTableViewCell.h
//  KNNews
//
//  Created by Kevin Yin on 5/7/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "KNCommonTableViewCell.h"

@interface KNInfoTableViewCell : KNCommonTableViewCell

@property (nonatomic, weak) UIImageView *avatarImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *contentLabel;

@end
