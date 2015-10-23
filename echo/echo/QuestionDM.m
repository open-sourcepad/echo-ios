//
//  QuestionDM.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "QuestionDM.h"
#import "Constants.h"

@implementation QuestionDM
@synthesize questionID;
@synthesize questionDesc;
@synthesize questionAnswers;

+ (QuestionDM *)getQuestionFrom:(NSDictionary *)questionDict
{
    QuestionDM *question = [[QuestionDM alloc] init];
    question.questionID = [[questionDict objectForKey:KEY_UID] intValue];
    question.questionDesc = [questionDict objectForKey:KEY_QUESTION_DESC];
    question.questionAnswers = [questionDict objectForKey:KEY_ADDRESS];
    //Question Answers
    NSArray *questionAnswers = [questionDict objectForKey:KEY_VENUE_STREAM];
    questionAnswers.streamsArray = [NSMutableArray arrayWithArray:[StreamDM getStreamsFrom:streams]];
    
    if([venueDict objectForKey:KEY_VENUE_DISTANCE_KM] != [NSNull null])
        venue.distanceKM = [[venueDict objectForKey:KEY_VENUE_DISTANCE_KM] floatValue];
    if([venueDict objectForKey:KEY_VENUE_DISTANCE_MI] != [NSNull null])
        venue.distanceMI = [[venueDict objectForKey:KEY_VENUE_DISTANCE_MI] floatValue];
    if([venueDict objectForKey:KEY_YELP_LATITUDE] != [NSNull null])
        venue.yelpLatitude = [[venueDict objectForKey:KEY_YELP_LATITUDE] floatValue];
    if([venueDict objectForKey:KEY_YELP_LONGITUDE] != [NSNull null])
        venue.yelpLongitude = [[venueDict objectForKey:KEY_YELP_LONGITUDE] floatValue];
    
    return venue;
}

+ (NSArray *)getVenuesFrom:(NSArray *)array
{
    NSMutableArray *venues = [[NSMutableArray alloc] init];
    for(NSDictionary *venueDict in array)
        [venues addObject:[VenueDM getVenueFrom:venueDict]];
    return venues;
}

@end
