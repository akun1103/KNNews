//
//  CommonTableViewCell.m
//  WeChat
//
//  Created by emper on 15/11/19.
//  Copyright © 2015年 Kevin. All rights reserved.
//

#import "KNCommonTableViewCell.h"

@implementation KNCommonTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _topLineStyle = CellLineStyleNone;
        _bottomLineStyle = CellLineStyleDefault;
        self.leftFreeSpace = self.frameWidth * 0.05;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.topLine setOriginY:0];
    [self.bottomLine setOriginY:self.frameHeight - _bottomLine.frameHeight];
    [self setBottomLineStyle:_bottomLineStyle];
    [self setTopLineStyle:_topLineStyle];
}

- (void) setTopLineStyle:(CellLineStyle)style
{
    _topLineStyle = style;
    if (style == CellLineStyleDefault) {
        [self.topLine setOriginX:_leftFreeSpace];
        [self.topLine setFrameWidth:self.frameWidth - _leftFreeSpace];
        [self.topLine setHidden:NO];
    }
    else if (style == CellLineStyleSpace){
        [self.topLine setOriginX:_leftFreeSpace];
        [self.topLine setFrameWidth:self.frameWidth - _leftFreeSpace * 2];
        [self.topLine setHidden:NO];
    }
    else if (style == CellLineStyleFill) {
        [self.topLine setOriginX:0];
        [self.topLine setFrameWidth:self.frameWidth];
        [self.topLine setHidden:NO];
    }
    else if (style == CellLineStyleNone) {
        [self.topLine setHidden:YES];
    }
}

- (void) setBottomLineStyle:(CellLineStyle)style
{
    _bottomLineStyle = style;
    if (style == CellLineStyleDefault) {
        [self.bottomLine setOriginX:_leftFreeSpace];
        [self.bottomLine setFrameWidth:self.frameWidth - _leftFreeSpace];
        [self.bottomLine setHidden:NO];
    }
    else if (style == CellLineStyleSpace){
        [self.bottomLine setOriginX:_leftFreeSpace];
        [self.bottomLine setFrameWidth:self.frameWidth - _leftFreeSpace * 2];
        [self.bottomLine setHidden:NO];
    }
    else if (style == CellLineStyleFill) {
        [self.bottomLine setOriginX:0];
        [self.bottomLine setFrameWidth:self.frameWidth];
        [self.bottomLine setHidden:NO];
    }
    else if (style == CellLineStyleNone) {
        [self.bottomLine setHidden:YES];
    }
}

- (UIView *) bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        [_bottomLine setFrameHeight:0.5f];
        [_bottomLine setBackgroundColor:DEFAULT_LINE_GRAY_COLOR];
        [_bottomLine setAlpha:0.4];
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIView *) topLine
{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] init];
        [_topLine setFrameHeight:0.5f];
        [_topLine setBackgroundColor:DEFAULT_LINE_GRAY_COLOR];
        [_topLine setAlpha:0.4];
        [self.contentView addSubview:_topLine];
    }
    return _topLine;
}

@end
