//
//  KNMeViewController.h
//  KNNews
//
//  Created by emper on 16/5/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KNViewController.h"

@interface KNMeViewController : KNViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end
