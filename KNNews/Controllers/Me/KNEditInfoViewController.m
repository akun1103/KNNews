//
//  KNEditInfoViewController.m
//  KNNews
//
//  Created by Kevin Yin on 5/7/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "KNEditInfoViewController.h"

@interface KNEditInfoViewController ()

@end

@implementation KNEditInfoViewController

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
    [self setupAvatarImageView];
    [self setupNameTextField];
    [self setupSignatureTextView];
}

- (void)keyboardWillChangeFrame: (NSNotification *)notification {
    if (_isEditTextView) {
        CGRect frame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
        CGFloat spaceY = 20.0;
        CGFloat height = frame.origin.y - spaceY - CGRectGetMaxY(self.signatureTextView.frame);
        if (frame.origin.y >= self.view.frame.size.height) {
            height = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        }
        NSLog(@"%f",height);
        double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration:duration animations:^{
             self.view.frame = CGRectMake(0, height, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submitEdit {
    [[NSUserDefaults standardUserDefaults] setObject:_nameTextField.text forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:_signatureTextView.text forKey:@"userSignature"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"avatarImage"];
    [UIImagePNGRepresentation(self.avatarImageView.image) writeToFile:path atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupNavigationBar {
    self.title = @"个人中心";
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBar;
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(submitEdit)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)setupAvatarImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake((self.view.frame.size.width - 100)/2, 30, 100, 100);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = YES;
    imageView.layer.cornerRadius = 50;
    imageView.layer.masksToBounds = YES;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"avatarImage"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imageView.image = image;
    [self.view addSubview:imageView];
    self.avatarImageView = imageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAvatarImage)];
    [self.avatarImageView addGestureRecognizer:tap];
}

- (void)setupNameTextField {
    CGFloat spaceX = 30.0;
    CGFloat spaceY = 0;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(spaceX, CGRectGetMaxY(self.avatarImageView.frame) + spaceY, 100, 30);
    label.textColor = DEFAULT_TEXT_GRAY_COLOR;
    label.text = @"匿名";
    [self.view addSubview:label];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(spaceX, CGRectGetMaxY(label.frame) + spaceY, self.view.frame.size.width - 2 * spaceX, 30);
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont systemFontOfSize:15];
    textField.layer.cornerRadius = 5.0;
    textField.layer.masksToBounds = YES;
    textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    [self.view addSubview:textField];
    self.nameTextField = textField;
}

- (void)setupSignatureTextView {
    CGFloat spaceX = 30.0;
    CGFloat spaceY = 0;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(spaceX, CGRectGetMaxY(self.nameTextField.frame) + 10, 100, 30);
    label.textColor = DEFAULT_TEXT_GRAY_COLOR;
    label.text = @"个性签名";
    [self.view addSubview:label];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(spaceX, CGRectGetMaxY(label.frame) + spaceY, self.view.frame.size.width - 2 * spaceX, 100);
    textView.backgroundColor = [UIColor whiteColor];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:15];
    textView.layer.cornerRadius = 5.0;
    textView.layer.masksToBounds = YES;
    textView.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSignature"];
    [self.view addSubview:textView];
    self.signatureTextView = textView;
}

- (void)changeAvatarImage {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.allowsEditing = YES;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.signatureTextView resignFirstResponder];
    [self.nameTextField resignFirstResponder];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo  {
    self.avatarImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.isEditTextView = YES;
    return YES;
}
@end
