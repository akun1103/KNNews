//
//  CommonTableViewCell.h
//  WeChat
//
//  Created by emper on 15/11/19.
//  Copyright © 2015年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellLineStyle) {
    CellLineStyleDefault,
    CellLineStyleSpace,
    CellLineStyleFill,
    CellLineStyleNone
};

@interface KNCommonTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *topLine;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,assign) float leftFreeSpace;

@property (nonatomic,assign) CellLineStyle bottomLineStyle;
@property (nonatomic,assign) CellLineStyle topLineStyle;

@end
