//
//  AnswerDM.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "AnswerDM.h"
#import "Constants.h"

@implementation AnswerDM
+ (AnswerDM *)getAnswerFrom:(NSDictionary *)answerDict
{
    AnswerDM *answer = [[AnswerDM alloc] init];
    answer.imageUrl = [answerDict objectForKey:KEY_ANSWER_IMAGE_URL];
    answer.ansDesc = [answerDict objectForKey:KEY_ANSWER_DESC];
    
    return answer;
}

+ (NSArray *)getAnswersFrom:(NSArray *)array
{
    NSMutableArray *answers = [[NSMutableArray alloc] init];
    for(NSDictionary *answerDict in array)
        [answers addObject:[AnswerDM getAnswerFrom:answerDict]];
    return answers;
}
@end
