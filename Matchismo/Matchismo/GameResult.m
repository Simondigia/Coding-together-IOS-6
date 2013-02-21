//
//  GameResult.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 11.2.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "GameResult.h"
@interface GameResult()
@property (readwrite,nonatomic) NSDate *start;
@property (readwrite,nonatomic) NSDate *end;

@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"

-(void) synchronize
{
    NSMutableDictionary *mutableGameResultsFromUserDefualts=[[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY ] mutableCopy];
    if(!mutableGameResultsFromUserDefualts) mutableGameResultsFromUserDefualts=[[NSMutableDictionary alloc]init];
    mutableGameResultsFromUserDefualts[[self.start description]]=[self asPropertyList];
    [[NSUserDefaults standardUserDefaults]setObject:mutableGameResultsFromUserDefualts forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"



+ (NSArray *)allGameResults
{
    NSMutableArray *allGameResults=[[NSMutableArray alloc] init];
    
    for( id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]){
        GameResult *result=[[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    return  allGameResults;
}

-(id) initFromPropertyList:(id) plist
{
    self=[super init];
    if(self)
    {
        if([plist isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *resultDictanory=(NSDictionary *) plist;
            _start=resultDictanory[START_KEY];
            _end=resultDictanory[END_KEY];
            _score=[resultDictanory[SCORE_KEY] intValue];
            if(! _start || ! _end ) self=nil;
        }
    }
    return  self;
}

-(id)asPropertyList
{
    return @{START_KEY:self.start, END_KEY :self.end, SCORE_KEY: @(self.score)};
}
//designeted initilazer
-(id) init
{
    self= [super init];
    if( self)
    {
        _start=[NSDate date];
        _end=_start;
    }
    return self;
}

-(NSTimeInterval) duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

-(void) setScore:(int)score
{
    _score=score;
    self.end=[NSDate date];
    [self synchronize];
}
- (NSComparisonResult)dateCompare:(GameResult *)aGameResult {
    return ([self.end compare:aGameResult.end]);
}

- (NSComparisonResult)scoreCompare:(GameResult *)aGameResult {
    return ([@(self.score)compare:@(aGameResult.score)]);
}

- (NSComparisonResult)durationCompare:(GameResult *)aGameResult {
    return ([@(self.duration)compare:@(aGameResult.duration)]);
}
@end
