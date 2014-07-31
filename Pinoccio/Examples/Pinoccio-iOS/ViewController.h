//
//  ViewController.h
//  Pinoccio-iOS
//
//  Created by Haifisch on 6/18/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pinoccio.h"
@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource , UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UILabel *troopName;
@property (strong, nonatomic) IBOutlet UILabel *scoutName;
@property (strong, nonatomic) IBOutlet UILabel *onBoardTemperature;

- (IBAction)login:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)ledChanged:(id)sender;

@end

