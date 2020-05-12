//
//  ConfigurationViewController.m
//  GIOEdemo
//
//  Created by BeyondChao on 2020/5/12.
//  Copyright © 2020 M. All rights reserved.
//

#import "ConfigurationViewController.h"
#import "ConfigurationModel.h"
#import <Growing.h>

@interface ConfigurationViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *flushIntervalTextField;
@property (weak, nonatomic) IBOutlet UITextField *sessionIntervalTextField;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;

@property (nonatomic, strong) ConfigurationModel *configModel;

@end

@implementation ConfigurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"配置信息";

    [self displayConfig];
}

- (void)displayConfig {
    self.configModel = [ConfigurationModel readConfigration];
    if (self.configModel.userID) {
        self.userIdTextField.text = self.configModel.userID;
        self.flushIntervalTextField.text = [NSString stringWithFormat:@"%0.0f", self.configModel.flushInterval];
        self.sessionIntervalTextField.text = [NSString stringWithFormat:@"%0.0f", self.configModel.sessionInterval];
    }
    
    [self updateSettingButton];
}

- (void)updateSettingButton {
    self.settingButton.enabled = self.userIdTextField.text.length > 0 && self.flushIntervalTextField.text.length > 0 && self.sessionIntervalTextField.text.length > 0;
}

- (IBAction)settingBtnClick:(UIButton *)sender {
    [self.view resignFirstResponder];
    
    if (self.configModel.userID) {
        [ConfigurationModel saveConfiguration:self.configModel];
        
        [Growing setUserId:self.configModel.userID];
        [Growing setFlushInterval:self.configModel.flushInterval];
        [Growing setSessionInterval:self.configModel.sessionInterval];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)textFiledValueChanged:(UITextField *)sender {
    
    if (!self.configModel) {
        self.configModel = [[ConfigurationModel alloc] init];
    }
    
    if (sender == self.userIdTextField) {
        self.configModel.userID = sender.text;
    } else if (sender == self.flushIntervalTextField) {
        self.configModel.flushInterval = self.flushIntervalTextField.text.doubleValue;
    } else if (sender == self.sessionIntervalTextField) {
        self.configModel.sessionInterval = self.sessionIntervalTextField.text.doubleValue;
    }
    
    [self updateSettingButton];
}

#pragma mark UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger nextTag = textField.tag + 1;
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return NO;
}

- (void)dealloc {
    NSLog(@"dealloc...");
}

@end
