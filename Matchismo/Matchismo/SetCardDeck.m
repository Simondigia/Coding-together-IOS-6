//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 19.2.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//
#import "SetCard.h"
#import "SetCardDeck.h"

@implementation SetCardDeck
- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.number = number;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
