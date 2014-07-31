//
//  Pinoccio.h
//  Pinoccio
//
//  Created by Haifisch on 6/18/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pinoccio : NSObject
/*
    Notes;
        Most of these functions use a block for completion, if you're unfimiliar with block syntax, I suggest you visit http://fuckingblocksyntax.com/ 
        Most of these blocks include a BOOL to give confirmation that the function was executed without a problem, so,  BOOL = YES/TRUE then it should be OK, if else, you know what to do.
 */


-(void)loginWithCredentials:(NSString *)email password:(NSString *)password withCompletion:(void (^)(NSString *, BOOL))block; // String is the session token, store this in a global variable or NSUserDefaults if perfered.

-(void)logoutWithToken:(NSString *)token withCompletion:(void (^)(BOOL))block; // Completes with BOOL, YES = logged out and NO = logout was unsuccessful

-(void)troopWithToken:(NSString *)token withCompletion:(void (^)(NSArray *, BOOL))block; // Returns an array of troops for the account

-(void)scoutsWithTroopID:(NSInteger)troopID withToken:(NSString *)token withCompletion:(void (^)(NSArray *, BOOL))block;

-(void)led:(BOOL)ledBOOL withScoutID:(NSInteger)scoutID withTroopID:(NSInteger)troopID withToken:(NSString *)token withCompletion:(void (^)(BOOL))block;
-(void)sendBitlash:(NSString*)command withScoutID:(NSInteger)scoutID withTroopID:(NSInteger)troopID withToken:(NSString *)token withCompletion:(void (^)(NSDictionary *, BOOL))block;

@end
