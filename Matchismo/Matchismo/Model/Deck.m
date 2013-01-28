//
//  Desk.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 28.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "Deck.h"
@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end


@implementation Deck

//laze init
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (!card) {
        return;
    }
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}



-(Card *)drawRandomCard
{
    // just for show
    Card *randomCard = nil;
    
    if (self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}


@end
