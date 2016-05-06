//
//  KNChannelCollectionViewCell.m
//  KNNews
//
//  Created by emper on 16/5/6.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KNChannelCollectionViewCell.h"

@implementation KNChannelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.nameLabel = label;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"channel_edit_delete"] forState:UIControlStateNormal];
        button.hidden = YES;
        [self addSubview:button];
        self.deleteButton = button;
        
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor whiteColor];
        self.backgroundView = backgroundView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = 4;
    
    self.nameLabel.frame = CGRectMake(space, space, self.frame.size.width - 2 * space, self.frame.size.height - 2 * space);
    self.deleteButton.frame = CGRectMake(self.frame.size.width - 16, 0, 16, 16);
    self.backgroundView.frame = CGRectMake(space, space, self.frame.size.width - 2 * space, self.frame.size.height - 2 * space);
}

- (void)deleteButtonClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(deleteCellAtIndexPath:)]) {
        [self.delegate deleteCellAtIndexPath:_indexPath];
    }
}
@end
