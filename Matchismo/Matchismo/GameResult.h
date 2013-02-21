//
//  GameResult.h
//  Matchismo
//
//  Created by Ozrenko Dragic on 11.2.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+( NSArray *) allGameResults;
@property (readonly,nonatomic) NSDate *start;
@property (readonly,nonatomic) NSDate *end;
@property (readonly,nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

- (NSComparisonResult)dateCompare:(GameResult *)aGameResult;
- (NSComparisonResult)scoreCompare:(GameResult *)aGameResult;
- (NSComparisonResult)durationCompare:(GameResult *)aGameResult;

@end
