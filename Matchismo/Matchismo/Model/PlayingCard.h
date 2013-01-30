//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ozrenko Dragic on 28.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property(weak, nonatomic)NSString *suit;
@property(nonatomic) NSUInteger rank;
//ili ti static metode
//mogu da se pozovu iako objekat nije naprevljen
+(NSArray *) validSuits;
+(NSUInteger) maxRank;
@end
