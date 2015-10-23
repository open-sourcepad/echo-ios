//
//  QuestionDM.h
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnswerDM.h"
@class AnswerDM;

@interface QuestionDM : NSObject
@property (strong, nonatomic) NSArray *answerArray;
@property (strong, nonatomic) NSString *questionDesc;
@property (nonatomic) int questionID;

+ (QuestionDM *)getQuestionFrom:(NSDictionary *)questionDict;
+ (NSArray *)getQuestionsFrom:(NSDictionary *)detailDict;
@end
