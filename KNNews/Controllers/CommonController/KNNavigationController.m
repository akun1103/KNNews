//
//  KNNavigationController.m
//  KNNews
//
//  Created by emper on 16/5/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KNNavigationController.h"

@interface KNNavigationController ()

@end

@implementation KNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = DEFAULT_TABBAR_COLOR;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(self.childViewControllers.count > 0) {
        [self addbackBtn:viewController];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

- (void)addbackBtn:(UIViewController *)viewController {
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    viewController.navigationItem.leftBarButtonItems = @[back];
}

- (void)backBtnClick {
    [self popViewControllerAnimated:YES];
}

@end
