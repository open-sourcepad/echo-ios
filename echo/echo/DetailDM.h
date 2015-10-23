//
//  DetailDM.h
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailDM : NSObject
@property (nonatomic) int quesID;
@property (strong,nonatomic) NSString *quesDesc;
+ (DetailDM *)getDetailFrom:(NSDictionary *)quesDict;
+ (NSArray *)getDetailsFrom:(NSArray *)array;
@end
