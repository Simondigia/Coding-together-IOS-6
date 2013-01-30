//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ozrenko Dragic on 30.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
@interface CardMatchingGame : NSObject
- (id) initWithCardCount:(NSUInteger) cardCount
              usingDeck:(Deck*) deck;
- (NSString*) flipCardAtIndex:(NSUInteger) index;
- (Card*) cardAtIndex:(NSUInteger) index;
@property (nonatomic) int mode;
@property(readonly,nonatomic) int score;
@end
