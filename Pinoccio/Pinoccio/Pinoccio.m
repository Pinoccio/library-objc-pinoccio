//
//  Pinoccio.m
//  Pinoccio
//
//  Created by Haifisch on 6/18/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import "Pinoccio.h"

@implementation Pinoccio
-(void)loginWithCredentials:(NSString *)email password:(NSString *)password withCompletion:(void (^)(NSString *, BOOL))block {
    NSString *post = [NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\"}",email,password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://api.pinocc.io/v1/login"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    if (results != nil && results[@"data"][@"token"] != nil) {
        block(results[@"data"][@"token"], YES); // Got data OK, now return it.
    }else {
        block(results[@"error"][@"message"], NO); // Oh no! Check user name and password.
    }
}

-(void)logoutWithToken:(NSString *)token withCompletion:(void (^)(BOOL))block {
    NSString *post = [NSString stringWithFormat:@"token=%@",token];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://api.pinocc.io/v1/logout"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *error;
    
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    if (results != nil && [results[@"data"] integerValue] == 1) {
        block(YES); // Logged out!
    }else if ([results[@"data"] integerValue] == 0){
        block(NO); // Not ok :(
    }
}

-(void)troopWithToken:(NSString *)token withCompletion:(void (^)(NSArray *, BOOL))block {
    NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.pinocc.io/v1/troops?token=%@",token]];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlString];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               id temporaryDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               if (!error && !temporaryDictionary[@"error"]){
                                   block(temporaryDictionary[@"data"], YES);
                               }else if (!error && temporaryDictionary[@"error"]){
                                   block(temporaryDictionary, NO);
                               }else {
                                   block([[error userInfo] mutableCopy], NO);
                               }
                           }];
}

-(void)scoutsWithTroopID:(NSInteger)troopID withToken:(NSString *)token withCompletion:(void (^)(NSArray *, BOOL))block {
    NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.pinocc.io/v1/%ld/scouts?token=%@",(long)troopID,token]];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlString];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               id temporaryDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               if (!error && !temporaryDictionary[@"error"]){
                                   block(temporaryDictionary[@"data"], YES);
                               }else if (!error && temporaryDictionary[@"error"]){
                                   block(temporaryDictionary, NO);
                               }else {
                                   block([[error userInfo] mutableCopy], NO);
                               }
                           }];
}

-(void)led:(BOOL)ledBOOL withScoutID:(NSInteger)scoutID withTroopID:(NSInteger)troopID withToken:(NSString *)token withCompletion:(void (^)(BOOL))block {
    NSURL *urlString;
    if (ledBOOL) {
        urlString = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.pinocc.io/v1/%ld/%ld/command/led.on?token=%@",(long)troopID,(long)scoutID,token]];
    }else {
        urlString = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.pinocc.io/v1/%ld/%ld/command/led.off?token=%@",(long)troopID,(long)scoutID,token]];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:urlString];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               id temporaryDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               if (!error && !temporaryDictionary[@"error"]){
                                   block(YES);
                               }else if (!error && temporaryDictionary[@"error"]){
                                   block(NO);
                               }else {
                                   block(NO);
                               }
                           }];
}

-(void)sendBitlash:(NSString*)command withScoutID:(NSInteger)scoutID withTroopID:(NSInteger)troopID withToken:(NSString *)token withCompletion:(void (^)(NSDictionary *, BOOL))block {
    NSString *urlStr = [NSString stringWithFormat:@"https://api.pinocc.io/v1/%ld/%ld/command/%@?token=%@",(long)troopID,scoutID,[command stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],token];
    NSURL *urlString = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlString];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               id temporaryDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               NSLog(@"%@",temporaryDictionary);

                               if (!error && !temporaryDictionary[@"error"]){
                                   block(temporaryDictionary[@"data"], YES);
                               }else if (!error && temporaryDictionary[@"error"]){
                                   block(temporaryDictionary, NO);
                               }else {
                                   block([[error userInfo] mutableCopy], NO);
                               }
                           }];
}

@end
