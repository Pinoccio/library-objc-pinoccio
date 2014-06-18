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
}
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    pinoccioAPI = [[Pinoccio alloc] init]; // Initialize library in memory
    
    // Generate token, email and password parameter is REQUIRED
    [pinoccioAPI generateTokenWithEmail:@"dylan@pinocc.io" password:@"Testing123456" withCompletion:^(NSString *generatedToken, BOOL isOK){
        if (isOK){
            NSLog(@"Generated token!");
            token = generatedToken;
        }else {
            NSLog(@"Username and password is incorrect!");
        }
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
