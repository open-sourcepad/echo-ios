//
//  UserDM.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "UserDM.h"
#import "AppDelegate.h"
#import "Constants.h"

@implementation UserDM
@synthesize userID;
@synthesize email;
@synthesize password;
@synthesize accessToken;

#define kUserID                 @"uid"
#define kUserPassword           @"password"
#define kEmail                  @"email"
#define kUserAccessToken        @"auth_token"

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init])) {
        //decode properties, other class vars
        self.userID      = [decoder decodeObjectForKey:kUserID];
        self.password    = [decoder decodeObjectForKey:kUserPassword];
        self.email    = [decoder decodeObjectForKey:kEmail];
        self.accessToken = [decoder decodeObjectForKey:kUserAccessToken];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userID forKey:kUserID];
    [encoder encodeObject:self.password forKey:kUserPassword];
    [encoder encodeObject:self.email forKey:kEmail];
    [encoder encodeObject:self.accessToken forKey:kUserAccessToken];
 }

+ (void)storeUserInfo:(NSDictionary *)userDict
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UserDM *user = [UserDM parseInfo:userDict];
    
    appDelegate.currentUser.password      = user.password;
    appDelegate.currentUser.userID        = user.userID;
    appDelegate.currentUser.email      = user.email;
    if(user.accessToken)
        appDelegate.currentUser.accessToken   = user.accessToken;
    else
        appDelegate.currentUser.accessToken = appDelegate.currentUser.accessToken;
 
    // Save current user
    [UserDM saveCustomObject:appDelegate.currentUser key:DEFAULT_CURRENT_USER];
}

+ (UserDM *)parseInfo:(NSDictionary *)userDict
{
    UserDM *user = [[UserDM alloc] init];
    
    user.userID      = [userDict objectForKey:kUserID];
    user.email    = [userDict objectForKey:kEmail];
    user.password      = [userDict objectForKey:kUserPassword];
    user.accessToken = [userDict objectForKey:kUserAccessToken];
    return user;
}

+ (UserDM *)loadCustomObjectWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    UserDM *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return user;
}

+ (void)saveCustomObject:(UserDM *)user key:(NSString *)key
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}

+ (NSArray *)getUserFrom:(NSArray *)array
{
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    for(NSDictionary *dictionary in array)
        [objects addObject:[self parseInfo:dictionary]];
    
    return objects;
}
@end
