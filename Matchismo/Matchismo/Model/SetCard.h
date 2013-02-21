//
//  SetCard.h
//  Matchismo
//
//  Created by Ozrenko Dragic on 19.2.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong,nonatomic) NSString *color;
@property (strong, nonatomic ) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) int number;
+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (int)maxNumber;


@end
