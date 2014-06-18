//
//  Pinoccio.h
//  Pinoccio
//
//  Created by Haifisch on 6/18/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pinoccio : NSObject

-(void)generateTokenWithEmail:(NSString *)email password:(NSString *)password withCompletion:(void (^)(NSString *, BOOL))block;

@end
