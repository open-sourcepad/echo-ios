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
    answer.answerID = [[answerDict valueForKey:KEY_ID]intValue];
    answer.imageUrl = [answerDict objectForKey:KEY_IMAGE_URL];
    answer.ansDesc = [answerDict objectForKey:KEY_DESCRIPTION];
    answer.positionID = [[answerDict valueForKey:KEY_POSITION]intValue];
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
