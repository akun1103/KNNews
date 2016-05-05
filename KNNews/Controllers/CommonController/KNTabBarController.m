//
//  KNTabBarController.m
//  KNNews
//
//  Created by emper on 16/5/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KNTabBarController.h"
#import "KNNavigationController.h"
#import "KNNewsViewController.h"
#import "KNPictureViewController.h"
#import "KNVideoViewController.h"
#import "KNMeViewController.h"

@interface KNTabBarController ()

@end

@implementation KNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KNNewsViewController *news = [[KNNewsViewController alloc] init];
    [self addChildViewController:news withImage:[UIImage imageNamed:@"tabbar_news"] selectedImage:[UIImage imageNamed:@"tabbar_news_hl"] tittle:@"新闻"];
    KNPictureViewController *picture = [[KNPictureViewController alloc] init];
    [self addChildViewController:picture withImage:[UIImage imageNamed:@"tabbar_picture"] selectedImage:[UIImage imageNamed:@"tabbar_picture_hl"] tittle:@"图片"];
    KNVideoViewController *video = [[KNVideoViewController alloc] init];
    [self addChildViewController:video withImage:[UIImage imageNamed:@"tabbar_video"] selectedImage:[UIImage imageNamed:@"tabbar_video_hl"] tittle:@"视频"];
    KNMeViewController *me = [[KNMeViewController alloc] init];
    [self addChildViewController:me withImage:[UIImage imageNamed:@"tabbar_setting"] selectedImage:[UIImage imageNamed:@"tabbar_setting_hl"] tittle:@"我的"];
}

- (void)addChildViewController:(UIViewController *)childController withImage:(UIImage *)image selectedImage:(UIImage *)selectImage tittle:(NSString *)tittle {
    KNNavigationController *nav = [[KNNavigationController alloc] initWithRootViewController:childController];
    [childController.tabBarItem setImage:image];
    [childController.tabBarItem setSelectedImage:selectImage];
    [childController setTitle:tittle];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:DEFAULT_TABBAR_COLOR} forState:UIControlStateSelected];
    [self addChildViewController:nav];
}

@end
