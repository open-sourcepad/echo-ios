//
//  EchoAPI.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "EchoAPI.h"
#import "AppDelegate.h"
#import "Helpers.h"

@implementation EchoAPI
#pragma properties

-(AFHTTPSessionManager *)sessionManager{
    if(!_sessionManager){
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString: BASE_URL]];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [_sessionManager.requestSerializer setValue: @"application/vnd.echo+json;version=1" forHTTPHeaderField: @"Accept"];
    }
    return _sessionManager;
}

-(void)signInUser:(NSMutableDictionary *)params{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if([appDelegate reachable]){
        [self.sessionManager POST:API_SIGNIN parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"RESPONSE: %@", responseObject);
            if([[responseObject objectForKey:KEY_SUCCESS]boolValue]==1){
                [UserDM storeUserInfo:[responseObject objectForKey:KEY_DATA]];
                [appDelegate launchHomeScreen];
            }else{
                NSString *message = ALERT_ERROR;
                if([responseObject objectForKey:KEY_ERRORS]) {
                    if([[responseObject objectForKey:KEY_ERRORS] isKindOfClass:[NSString class]])
                        message = [responseObject objectForKey:KEY_ERRORS];
                    else {
                        if([[responseObject objectForKey:KEY_ERRORS] objectForKey:@"NSLocalizedDescription"])
                            message = [[responseObject objectForKey:KEY_ERRORS] objectForKey:@"NSLocalizedDescription"];
                    }
                }
                [Helpers alertStatus:message :ALERT_ERROR :0];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"failed error: %@",error.localizedDescription);
            [Helpers alertStatus:@"Invalid Email or Password" :@"Login Failed" :0];
        }];
    }else{
        [Helpers alertStatus:[NSString stringWithFormat:@"%@", ALERT_CONNECTION_ERROR]:@"" :0];
    }
}

-(void)getQuestions:(void (^)(NSDictionary *))completion{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:appDelegate.currentUser.accessToken forKey:KEY_AUTH_TOKEN];
    [param setObject:appDelegate.currentUser.userID forKey:KEY_UID];
    if([appDelegate reachable]){
        [self.sessionManager GET: API_GET_QUESTION
                      parameters: param
                         success: ^ (NSURLSessionDataTask *task, id responseObject)
         {
             NSMutableDictionary *resultDict = responseObject;
             if (completion)
             {
                 dispatch_async(dispatch_get_main_queue(), ^
                                {
                                    
                                    completion(resultDict);
                                });
             }
         }
                         failure: ^ (NSURLSessionDataTask *task, NSError *error)
         {
             if (completion)
             {
                 dispatch_async(dispatch_get_main_queue(), ^
                                {
                                    completion(nil);
                                });
                 NSLog(@"failed error: %@",error);
                 [Helpers alertStatus:@"No available questions." :@"" :0];
             }
         }];
    }else{
        [Helpers alertStatus:[NSString stringWithFormat:@"%@", ALERT_CONNECTION_ERROR]:@"" :0];
    }

}

-(void)postAnswer:(int)answerID completion:(void (^)(NSDictionary *))completion{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if([appDelegate reachable]){
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setObject:[NSNumber numberWithInt:answerID] forKey:KEY_ANSWER_ID];
        [self.sessionManager POST: API_POST_ANSWER
                       parameters: param
                          success: ^ (NSURLSessionDataTask *task, id responseObject)
         {
             NSMutableDictionary *resultDict = responseObject;
             if (completion)
             {
                 NSLog(@"RESULT: %@",resultDict);
                 dispatch_async(dispatch_get_main_queue(), ^
                                {
                                    completion(resultDict);
                                });
             }
         }
                          failure: ^ (NSURLSessionDataTask *task, NSError *error)
         {
             if (completion)
             {
                 dispatch_async(dispatch_get_main_queue(), ^
                                {
                                    completion(nil);
                                });
                 NSLog(@"failed error: %@",error);
                 [Helpers alertStatus:ALERT_TRY_AGAIN :ALERT_ERROR :0];
             }
         }];
        
    }else{
        [Helpers alertStatus:[NSString stringWithFormat:@"%@", ALERT_CONNECTION_ERROR]:@"" :0];
    }
}
@end
