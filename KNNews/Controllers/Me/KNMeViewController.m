//
//  KNMeViewController.m
//  KNNews
//
//  Created by emper on 16/5/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KNMeViewController.h"
#import "KNInfoTableViewCell.h"
#import "KNEditInfoViewController.h"
#import "KNFeedbackViewController.h"

@interface KNMeViewController ()

@end

@implementation KNMeViewController

static NSString * const reuseIdentifier = @"Cell";
static CGFloat headerViewHeight = 30.0;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView registerClass:[KNInfoTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else {
        return 44;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerViewHeight);
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerViewHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KNCommonTableViewCell *cell = [[KNCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (indexPath.section == 0) {
       KNInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"avatarImage"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        if (image == nil) {
            image = [UIImage imageNamed:@"defaultUserIcon"];
            [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
        }
        cell.avatarImageView.image = image;
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        NSString *content = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSignature"];
        cell.nameLabel.text = name;
        cell.contentLabel.text = content;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.topLineStyle = CellLineStyleFill;
        cell.bottomLineStyle = CellLineStyleFill;
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ MB",@"10.0"];
            cell.topLineStyle = CellLineStyleFill;
            cell.bottomLineStyle = CellLineStyleFill;
        }
    } else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"反馈";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.topLineStyle = CellLineStyleFill;
            cell.bottomLineStyle = CellLineStyleDefault;
        } else if(indexPath.row == 1) {
            cell.textLabel.text = @"关于";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.topLineStyle = CellLineStyleNone;
            cell.bottomLineStyle = CellLineStyleFill;
        }
    }
    return cell;
}

#pragma mark - UITabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        KNEditInfoViewController *controller = [[KNEditInfoViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            KNFeedbackViewController *controller = [[KNFeedbackViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}
@end
