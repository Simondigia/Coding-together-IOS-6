//
//  PlayingDesk.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 28.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "PlayingDeck.h"

@implementation PlayingDeck
-(id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:NO];
            }
        }
    }
    
    
    return self;
}

@end
