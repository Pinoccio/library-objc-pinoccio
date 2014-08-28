//
//  ViewController.m
//  Pinoccio-iOS
//
//  Created by Haifisch on 6/18/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    Pinoccio *pinoccioAPI;
    NSString *token;
    BOOL isLoggedIn;
    NSArray *globalScouts;
    NSInteger selectedScout;
    NSInteger selectedTroop;

}


@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    pinoccioAPI = [[Pinoccio alloc] init]; // Initialize library
    double x = 192826;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)getAllData {
    [pinoccioAPI troopWithToken:token withCompletion:^(NSArray *troops, BOOL isOK) {
        if (isOK) {
            self.troopName.text = troops[0][@"name"];
            selectedTroop = [troops[0][@"id"] integerValue];
            [pinoccioAPI scoutsWithTroopID:[troops[0][@"id"] integerValue] withToken:token withCompletion:^(NSArray *scoutArray, BOOL isOK) {
                if (isOK) {
                    globalScouts = scoutArray;
                    [(UIPickerView *)[self.view viewWithTag:3] reloadAllComponents];
                    
                }
            }];
        }else {
            NSLog(@"Data is nil/null, check if user is logged in and token is valid.");
        }
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    [pinoccioAPI setPinoccioPassword:self.passwordField.text];
    [pinoccioAPI setPinoccioEmail:self.emailField.text];
    [pinoccioAPI loginwithCompletion:^(NSString *generatedToken, BOOL isOK) {
        if (isOK){
            token = generatedToken;
            isLoggedIn = YES;
            
        }else {
            NSLog(@"Username and password is incorrect!");
        }
    }];
    
    if (isLoggedIn) {
        [self getAllData];
    }else {
        NSLog(@"User not logged in!");
    }
}

- (IBAction)logout:(id)sender {
    [pinoccioAPI logoutWithToken:token withCompletion:^(BOOL isOK) {
        if (isOK) {
            [[[UIAlertView alloc] initWithTitle:@"Success!" message:@"You're logged out :D" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
    }];
}

- (IBAction)ledChanged:(id)sender {
    UISwitch *ledSwitch = (UISwitch *)sender;
    
    [pinoccioAPI led:ledSwitch.isOn withScoutID:selectedScout withTroopID:selectedTroop withToken:token withCompletion:^(BOOL isOK) {
        if (isOK) {
            NSLog(@"LED Toggled");
        }
    }];
}

#pragma mark TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    switch (textField.tag) {
        case 1:
            [(UITextField *)[self.view viewWithTag:2] becomeFirstResponder];
            break;

        default:
            [textField resignFirstResponder];
            break;
    }
    return YES;
}


#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return globalScouts.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return globalScouts[row][@"name"];
}

#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    selectedScout = [globalScouts[row][@"id"] integerValue];
    self.scoutName.text = globalScouts[row][@"name"];
    [pinoccioAPI sendBitlash:@"print temperature.f" withScoutID:selectedScout withTroopID:selectedTroop withToken:token withCompletion:^(NSDictionary *returnedJSON, BOOL isOK) {
        if (isOK) {
            self.onBoardTemperature.text = [NSString stringWithFormat:@"Temperature:%@ °F",returnedJSON[@"reply"]];
        }
    }];
}
@end
