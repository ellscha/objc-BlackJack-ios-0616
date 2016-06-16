//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Elli Scharlin on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"


@implementation FISBlackjackPlayer

/*
 name: Player
 cards: ♠A ♠J
 handscore  : 21
 ace in hand: 1
 stayed     : 1
 blackjack  : 1
 busted     : 0
 wins  : 2
 losses: 0
 */
-(instancetype)init{
    return [self initWithName:@""];
}

-(instancetype) initWithName:(NSString *)name{
    self = [super init];
    
    if (self) {
        _name = name;
        _cardsInHand = [NSMutableArray new];
        _handscore = 0;
        _wins = 0;
        _losses = 0;
        _aceInHand = NO;
        _blackjack = NO;
        _stayed = NO;
        _busted = NO;
        
    }
    return self;
}

-(void)resetForNewGame{
    [self.cardsInHand removeAllObjects];
    self.handscore = 0;
    self.aceInHand = NO;
    self.busted = NO;
    self.stayed = NO;
    self.blackjack = NO;
}
-(void)acceptCard:(FISCard *)card{
    [self.cardsInHand addObject:card];
    self.handscore += card.cardValue;
    
    
    BOOL aceInHandBool = NO;
    
    for (FISCard *isItAce in self.cardsInHand) {
        if (isItAce.cardValue == 1) {
            aceInHandBool = YES;
        }
    } if (aceInHandBool) {
        self.aceInHand = YES;
    } if (self.aceInHand) {
        if (self.handscore < 12) {
            self.handscore = self.handscore + 10;
        }
    }
    if (self.cardsInHand.count == 2) {
        if (self.handscore == 21) {
            self.blackjack = YES;
        }
    }
    
    if (self.handscore >=22) {
        self.busted = YES;
    }
    
}

-(BOOL)shouldHit{
    if (self.handscore >=16) {
        self.stayed = YES;
        return NO;
    }
    return YES;
    

}

-(NSString *)description{
    NSMutableString *description = [NSString stringWithFormat:@"name: %@ \ncards: %@ \nhandscore: %lu \nace in hand: %d \nstayed: %d \nblackjack: %d \nbusted: %d \nwins: %lu \nLosses: %lu",self.name, self.cardsInHand, self.handscore, self.aceInHand, self.stayed, self.blackjack, self.busted, self.wins, self.losses];
    return description;
}

@end
