//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 30.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (strong,nonatomic) NSMutableArray *cards;
@property (readwrite,nonatomic) int score;
@end
@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if(!_cards)_cards=[[NSMutableArray alloc]init];
    return _cards;
}
- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    
    self=[super init];
    if( self){
        for(int i=0;i<count;i++)
        {
            Card *card=[deck drawRandomCard];
            if(!card){
                self=nil;
            }
            else {
                self.cards[i]=card;
            }
        }
    }
    return self;
}

-(Card*) cardAtIndex:(NSUInteger)index
{
    return (index<self.cards.count) ? self.cards[index]: nil;
}
#define MATCH_BONUS 4
#define FLIP_COST 1
#define MISMATCH_PENALITY 2
- (NSString*) flipCardAtIndex:(NSUInteger)index
{
    NSString *description;
    Card *card=[self cardAtIndex:index];
    if (self.mode==2){
    if(!card.isUnplayable){
        if(!card.isFaceUp){
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore=[card match:@[otherCard]];
                    if( matchScore ) {
                            otherCard.unplayable=YES;
                            card.unplayable=YES;
                            self.score+=matchScore*MATCH_BONUS;
                            description=[NSString stringWithFormat:@"Matched %@  & %@ for 4 points",otherCard.contents,card.contents];
                    }
                    else{
                                otherCard.faceUp=NO;
                                self.score-=MISMATCH_PENALITY;
                                description=[NSString stringWithFormat:@"%@  and %@ don't match! 2 point penality",otherCard.contents,card.contents];
                         }
                    break;
              }
                else{
                    description=[NSString stringWithFormat:@"Flipped up %@ ",card.contents];
                }
            }
            self.score-=FLIP_COST;
        }
        card.faceUp=!card.isFaceUp;
      }
    }
    else if (self.mode==3){
        if(!card.isUnplayable && !card.isFaceUp){
            Card *secondCard, *thridCard;
            for ( Card* otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    if(!secondCard) {secondCard=otherCard;}
                     else if (!thridCard){ thridCard=otherCard; break; }
                }
            }
            if(thridCard && secondCard){
                int matchScore=[card match:@[secondCard]];
                if(matchScore){
                //check and thrid card
                int match2=[card match:@[thridCard]];
                if(matchScore==match2){
                    secondCard.unplayable=YES;
                    thridCard.unplayable=YES;
                    card.unplayable=YES;
                    self.score+=match2*MATCH_BONUS*2;
                    description=[NSString stringWithFormat:@"Matched %@  & %@ & %@",card.contents,secondCard.contents,thridCard];
                }
                        }
            //no match
            else{
                secondCard.faceUp=NO;
                thridCard.faceUp=NO;
                description=[NSString stringWithFormat:@"%@  and %@ and %@ don't match!",card.contents,secondCard.contents,thridCard.contents];
            }
                
        }
        }
        else{
            description=[NSString stringWithFormat:@"Flipped up %@ ",card.contents];
        }

        self.score-=FLIP_COST;
        card.faceUp=!card.faceUp;
    }
    return description;
}



@end
