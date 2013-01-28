//
//  Desk.h
//  Matchismo
//
//  Created by Ozrenko Dragic on 28.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject
//dodavanje karte ako je top je NO stavljamo ispod
-(void)addCard:(Card *)card atTop:(BOOL)atTop;
//vraca random kartu
-(Card *)drawRandomCard;
@end
