//
//  Pinoccio.m
//  Pinoccio
//
//  Created by Haifisch on 6/18/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import "Pinoccio.h"

@implementation Pinoccio
-(void)generateTokenWithEmail:(NSString *)email password:(NSString *)password withCompletion:(void (^)(NSString *, BOOL))block{
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
@end
