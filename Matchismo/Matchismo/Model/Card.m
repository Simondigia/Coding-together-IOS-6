//
//  Card.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 28.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int) match:(NSArray *)otherCards
{
    int score=0;
    for(Card *card in otherCards ){
        if(  [[card.contents string]  isEqualToString:  [self.contents string] ]){
            score=1;
        }
        
    }
    return score;
}
@end
