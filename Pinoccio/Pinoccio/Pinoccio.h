//
//  Pinoccio.h
//  Pinoccio
//
//  Created by Haifisch on 6/18/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"
@interface Pinoccio : NSObject {
    @private
    NSString *priv_email;
    NSString *priv_password;
    KeychainItemWrapper *keychainItem;
}
/*
    Notes;
        Most of these functions use a block for completion, if you're unfimiliar with block syntax, I suggest you visit http://fuckingblocksyntax.com/ 
        Most of these blocks include a BOOL to give confirmation that the function was executed without a problem, so,  BOOL = YES/TRUE then it should be OK, if else, you know what to do.
 */


// Token
-(void)setPinoccioEmail:(NSString *)email;
-(void)setPinoccioPassword:(NSString *)password;
-(void)loginWithCompletion:(void (^)(NSString *, BOOL))block;
-(void)logoutWithToken:(NSString *)token withCompletion:(void (^)(BOOL))block; // Completes with BOOL, YES = logged out and NO = logout was unsuccessful

// Troop management
-(void)troopWithToken:(NSString *)token withCompletion:(void (^)(NSArray *, BOOL))block; // Returns an array of troops for the account

// Scout management
-(void)scoutsWithTroopID:(NSInteger)troopID withToken:(NSString *)token withCompletion:(void (^)(NSArray *, BOOL))block;

// Scout controls
-(void)led:(BOOL)ledBOOL withScoutID:(NSInteger)scoutID withTroopID:(NSInteger)troopID withToken:(NSString *)token withCompletion:(void (^)(BOOL))block;
-(void)sendBitlash:(NSString*)command withScoutID:(NSInteger)scoutID withTroopID:(NSInteger)troopID withToken:(NSString *)token withCompletion:(void (^)(NSDictionary *, BOOL))block;

@end
