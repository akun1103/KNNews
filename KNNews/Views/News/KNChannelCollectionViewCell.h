//
//  KNChannelCollectionViewCell.h
//  KNNews
//
//  Created by emper on 16/5/6.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KNChannelCollectionViewCellDelegate <NSObject>

@optional

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface KNChannelCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<KNChannelCollectionViewCellDelegate> delegate;

@end
