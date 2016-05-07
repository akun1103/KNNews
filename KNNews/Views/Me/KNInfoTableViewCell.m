//
//  KNInfoTableViewCell.m
//  KNNews
//
//  Created by Kevin Yin on 5/7/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "KNInfoTableViewCell.h"

@implementation KNInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _avatarImageView = imageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:19];
        nameLabel.textColor = [UIColor blackColor];
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:13];
        contentLabel.textColor = DEFAULT_TEXT_GRAY_COLOR;
        [self addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat space = height * 0.1;
    _avatarImageView.frame = CGRectMake(space, space, height - 2 * space, height - 2 * space);
    _avatarImageView.layer.cornerRadius = _avatarImageView.frame.size.width * 0.5;
    _avatarImageView.layer.masksToBounds = YES;
    
    _nameLabel.frame = CGRectMake(height, 2 * space, width - height - 3 * space, 40);
    _contentLabel.frame = CGRectMake(height, height/2, width - height - 3 * space, 30);
}

@end
