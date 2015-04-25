//
//  ViewController.h
//  iTrash
//
//  Created by biid on 24/4/15.
//  Copyright (c) 2015 shibboleth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UISwitch *envassosSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *vidresSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *paperSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *organicSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *rebuigSwitch;

@property (weak, nonatomic) IBOutlet UISlider *radioSlider;

@property (weak, nonatomic) IBOutlet UILabel *radioLabel;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end

