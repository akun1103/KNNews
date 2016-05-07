//
//  KNFeedbackViewController.m
//  KNNews
//
//  Created by Kevin Yin on 5/7/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "KNFeedbackViewController.h"

@interface KNFeedbackViewController ()

@end

@implementation KNFeedbackViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    [self setupFeedbackTextView];
}

- (void)submitEdit {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupNavigationBar {
    self.title = @"反馈";
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitEdit)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)setupFeedbackTextView {
    CGFloat spaceX = 20.0;
    CGFloat spaceY = 20.0;
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(spaceX, spaceY, self.view.frame.size.width - 2 * spaceX, self.view.frame.size.height - 2 * spaceY - CGRectGetMaxY(self.navigationController.navigationBar.frame));
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    self.feedbackTextView = textView;
}

- (void)keyboardWillChangeFrame: (NSNotification *)notification {
    CGRect frame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat spaceX = 20.0;
    CGFloat spaceY = 20.0;
    self.feedbackTextView.frame = CGRectMake(spaceX, spaceY, self.view.frame.size.width - 2 * spaceX, frame.origin.y - 2 * spaceY - CGRectGetMaxY(self.navigationController.navigationBar.frame));
}
@end
