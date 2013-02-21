//
//  SetCard.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 19.2.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
#define MAX_NUMBER 3
@synthesize color = _color, symbol = _symbol, shading = _shading;


- (NSAttributedString *)contents
{
    return [self getAttributedStringFrom:self];
}


- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) _color = color;
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) _symbol = symbol;
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

- (void)setNumber:(int)number
{
    if (number <= [SetCard maxNumber]) _number = number;
}



+ (NSArray *)validColors{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbols
{
    return @[@"oval", @"squiggle", @"diamond"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"open", @"striped"];
}


+ (int)maxNumber{
    
    return MAX_NUMBER;
}


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == MAX_NUMBER - 1) {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        [colors addObject:self.color];
        [symbols addObject:self.symbol];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *otherSetCard = (SetCard *)otherCard;
                if (![colors containsObject:otherSetCard.color])
                    [colors addObject:otherSetCard.color];
                if (![symbols containsObject:otherSetCard.symbol])
                    [symbols addObject:otherSetCard.symbol];
                if (![shadings containsObject:otherSetCard.shading])
                    [shadings addObject:otherSetCard.shading];
                if (![numbers containsObject:@(otherSetCard.number)])
                    [numbers addObject:@(otherSetCard.number)];
                if (([colors count] == 1 || [colors count] == MAX_NUMBER)
                    && ([symbols count] == 1 || [symbols count] == MAX_NUMBER)
                    && ([shadings count] == 1 || [shadings count] == MAX_NUMBER)
                    && ([numbers count] == 1 || [numbers count] == MAX_NUMBER)) {
                    score = 4;
                }
            }
        }
    }
    
    return score;
}

- (NSAttributedString *)getAttributedStringFrom:  (SetCard *) card
{
    NSString *symbolString;  // the plain text string we will attribute
    // for the card.symbol
    if ([card.symbol isEqualToString:@"diamond"])
    {
        symbolString=@"▲";
    }
    else if ([card.symbol isEqualToString:@"squiggle"])
    {
        symbolString=@"●";
    }
    else if ([card.symbol isEqualToString:@"oval"])
    {
        symbolString=@"■";
    }
    
    // repeat the symbol 1, 2 or 3 times - for the card.number
    symbolString = [symbolString stringByPaddingToLength:card.number withString:symbolString startingAtIndex:0];
    
    NSMutableAttributedString *fancyString = [[NSMutableAttributedString alloc] initWithString:symbolString];
    
    NSRange wholeThing = NSMakeRange(0, [symbolString length]);
    
    // set the color - for the card.color
    UIColor *color;
    if ([card.color isEqualToString:@"red"])
    {
        color = [UIColor redColor];
    }
    else if ([card.color isEqualToString:@"green"])
    {
        color = [UIColor greenColor];
    }
    else if ([card.color isEqualToString:@"purple"])
    {
        color = [UIColor purpleColor];
    }
    
    
    // and the alpha for the card.shading
    if ([card.shading isEqualToString:@"solid"])
    {
        color = [color colorWithAlphaComponent:1.0f];
        [fancyString addAttribute:NSForegroundColorAttributeName value:color range:wholeThing];
    }
    else if ([card.shading isEqualToString:@"striped"])
    {
        color = [color colorWithAlphaComponent:0.3f];
        [fancyString addAttribute:NSForegroundColorAttributeName value:color range:wholeThing];
    }
    else if ([card.shading isEqualToString:@"open"])
    {
        [fancyString addAttribute:NSForegroundColorAttributeName value:[color colorWithAlphaComponent:0.02f] range:wholeThing];
        [fancyString addAttribute:NSStrokeColorAttributeName value:color range:wholeThing];
        [fancyString addAttribute:NSStrokeWidthAttributeName value:@4.0f
                            range:wholeThing];
    }
    
    return [fancyString copy];
}
@end
