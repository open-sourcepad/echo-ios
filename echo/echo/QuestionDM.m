//
//  QuestionDM.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "QuestionDM.h"
#import "AnswerDM.h"
#import "DetailDM.h"
#import "Constants.h"

@implementation QuestionDM
@synthesize answerArray;

+ (QuestionDM *)getQuestionFrom:(NSDictionary *)questionDict
{
    QuestionDM *question = [[QuestionDM alloc] init];

    NSDictionary *questDetail = [questionDict objectForKey:KEY_QUESTION];
    question.questionID = [[questDetail valueForKey:KEY_ID]intValue];
    question.questionDesc = [questDetail objectForKey:KEY_DESCRIPTION];

    //Question Answers
    NSArray *answersArray = [questionDict objectForKey:KEY_ANSWERS];
    question.answerArray = [NSMutableArray arrayWithArray:[AnswerDM getAnswersFrom:answersArray]];
    return question;
}

+ (NSArray *)getQuestionsFrom:(NSDictionary *)detailDict
{
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    [questions addObject:[QuestionDM getQuestionFrom:detailDict]];
    return questions;
}

@end
