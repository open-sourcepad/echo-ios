//
//  UserDM.h
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDM : NSObject
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *accessToken;

+(void)storeUserInfo:(NSDictionary *)userDict;
+ (void)saveCustomObject:(UserDM *)user key:(NSString *)key;
+ (UserDM *)loadCustomObjectWithKey:(NSString *)key;
+ (UserDM *)parseInfo:(NSDictionary *)userDict;
+ (NSArray *)getUserFrom:(NSArray *)array;
@end
