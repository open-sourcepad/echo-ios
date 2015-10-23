//
//  EchoAPI.h
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Constants.h"

@interface EchoAPI : NSObject
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
#pragma mark - public methods
-(void)signInUser:(NSMutableDictionary *)params;
-(void)getQuestions:(void (^)(NSDictionary *response)) completion;
-(void)postAnswer:(int)answerID completion:(void (^)(NSDictionary *response)) completion;
-(void)signOutUser:(NSMutableDictionary *)params;;
@end
