//
//  Card.h
//  Matchismo
//
//  Created by Ozrenko Dragic on 28.1.13..
//  Copyright (c) 2013. Ozrenko Dragic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;
//ime getter kako mi hocemo
@property(nonatomic,getter = isFaceUp) BOOL faceUp;
@property(nonatomic,getter = isUnplayable) BOOL unplayable;
-(int) match:(NSArray*) otherCards;
@end
