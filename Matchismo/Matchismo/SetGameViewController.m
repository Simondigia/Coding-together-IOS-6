//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Ozrenko Dragic on 19.2.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"
#import "SetCard.h"
@interface SetGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property(nonatomic) int flipsCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong,nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (strong,nonatomic) GameResult *gameResult;

@end

@implementation SetGameViewController

-(void) setCardButtons:(NSArray *)cardButtons
{
     _cardButtons=cardButtons;
    [self updateUI:[NSString stringWithFormat:@""]];
}


- (IBAction)newGame {
    self.game=nil;
    self.flipsCount=0;
    self.scoreLabel=0;
}

-(GameResult *) gameResult
{
    if(!_gameResult) _gameResult=[[GameResult alloc] init];
    return _gameResult;
}
-(CardMatchingGame*) game{
    if(!_game) {_game=[[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
        _game.mode=3;
    }
    return _game;
}
-(void) setFlipsCount:(int)flipsCount
{
    _flipsCount=flipsCount;
    self.flipsLabel.text=[NSString stringWithFormat:@"Flips: %d",self.flipsCount];
    self.gameResult.score=self.game.score;
}
- (IBAction)flipCard:(UIButton *)sender
{
    
    NSString *desc=[self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    self.flipsCount++;
    [self updateUI:desc ];
}

-(void) updateUI : (NSString*) description{
    
    self.description.text=description;
    self.scoreLabel.text=[NSString stringWithFormat:@"Score: %d", self.game.score];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
       ////////////////
        NSAttributedString *title;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            title = [self getAttributedStringFrom:setCard];
        }
        [cardButton setAttributedTitle:title forState:UIControlStateNormal];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        if (card.isFaceUp) {
            [cardButton setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
        } else {
            [cardButton setBackgroundColor:[UIColor clearColor]];
        }
    }
    

    
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
