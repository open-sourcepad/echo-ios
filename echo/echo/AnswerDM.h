//
//  AnswerDM.h
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerDM : NSObject
@property (strong,nonatomic) NSString *imageUrl;
@property (strong,nonatomic) NSString *ansDesc;
+ (AnswerDM *)getAnswerFrom:(NSDictionary *)answerDict;
+ (NSArray *)getAnswersFrom:(NSArray *)array;
@end
