//
//  DetailDM.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "DetailDM.h"
#import "Constants.h"

@implementation DetailDM
+ (DetailDM *)getDetailFrom:(NSDictionary *)detailDict
{
    DetailDM *ques = [[DetailDM alloc] init];
    ques.quesID = [[detailDict valueForKey:KEY_ID]intValue];
    ques.quesDesc = [detailDict objectForKey:KEY_DESCRIPTION];
    
    return ques;
}

+ (NSArray *)getDetailsFrom:(NSArray *)array
{
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    for(NSDictionary *quesDict in array)
        [questions addObject:[DetailDM getDetailFrom:quesDict]];
    return questions;
}
@end
