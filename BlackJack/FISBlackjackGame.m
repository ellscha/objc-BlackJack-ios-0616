    //
    //  FISBlackjackGame.m
    //  BlackJack
    //
    //  Created by Elli Scharlin on 6/16/16.
    //  Copyright © 2016 Flatiron School. All rights reserved.
    //

#import "FISBlackjackGame.h"

@implementation FISBlackjackGame

-(instancetype)init{
    self = [super init];
    
    if (self) {
        _deck = [[FISCardDeck alloc]init];
        _house = [[FISBlackjackPlayer alloc]initWithName:@"House"];
        _player = [[FISBlackjackPlayer alloc]initWithName:@"Player"];
    }
    return self;
}

-(void)playBlackjack{
    
}
-(void)dealNewRound{
    for (NSUInteger i = 1; i <= 2; i++) {
        [self dealCardToPlayer];
        [self dealCardToHouse];
    }
}
-(void)dealCardToPlayer{
    FISCard *cardToDeal = [[FISCard alloc]init];
    cardToDeal = self.deck.drawNextCard;
    [self.player acceptCard:cardToDeal];
    
}
-(void)dealCardToHouse{
    FISCard *cardToDeal = [[FISCard alloc]init];
    cardToDeal = self.deck.drawNextCard;
    [self.house acceptCard:cardToDeal];
}
-(void)processPlayerTurn{
    if (!self.player.stayed) {
        if (!self.player.busted) {
            if (self.player.shouldHit) {
                [self dealCardToPlayer];
            }
        }
    }
}
-(void)processHouseTurn{
    if (!self.house.stayed) {
        if (!self.house.busted) {
            if (self.house.shouldHit) {
                [self dealCardToHouse];
            }
        }
    }
}

-(BOOL)houseWins{
    BOOL doesHouseWin = YES;
    if (self.house.busted && !self.player.busted) {
        doesHouseWin = NO;
        
    } else if (self.house.blackjack && self.player.blackjack){
        doesHouseWin = NO;
        
    } else if (self.house.handscore < self.player.handscore && !self.player.busted){
        doesHouseWin = NO;
    }
    return doesHouseWin;
}
-(void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins{
    if (houseWins) {
        self.house.wins += 1;
        self.player.losses += 1;
        
    } else {
        self.player.wins +=1;
        self.house.losses += 1;
    }
}



@end
