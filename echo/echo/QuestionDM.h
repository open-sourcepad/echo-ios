//
//  QuestionDM.h
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionDM : NSObject
@property (nonatomic) int questionID;
@property (strong, nonatomic) NSString *questionDesc;
@property (strong, nonatomic) NSArray *questionAnswers;

+ (QuestionDM *)getQuestionFrom:(NSDictionary *)venueDict;
+ (NSArray *)getQuestionsFrom:(NSArray *)array;
@end
