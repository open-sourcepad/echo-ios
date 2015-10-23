//
//  AnswerDM.h
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerDM : NSObject
@property (nonatomic) int answerID;
@property (strong,nonatomic) NSString *imageUrl;
@property (strong,nonatomic) NSString *ansDesc;
@property (nonatomic) int positionID;
+ (AnswerDM *)getAnswerFrom:(NSDictionary *)answerDict;
+ (NSArray *)getAnswersFrom:(NSArray *)array;
@end
