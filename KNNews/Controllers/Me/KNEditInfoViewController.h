//
//  KNEditInfoViewController.h
//  KNNews
//
//  Created by Kevin Yin on 5/7/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import "KNViewController.h"

@interface KNEditInfoViewController : KNViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>

@property (nonatomic, weak) UIImageView *avatarImageView;
@property (nonatomic, weak) UITextField *nameTextField;
@property (nonatomic, weak) UITextView *signatureTextView;
@property (nonatomic, assign) BOOL isEditTextView;

@end
