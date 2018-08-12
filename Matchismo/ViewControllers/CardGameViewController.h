//
//  ViewController.h
//  Matchismo
//
//  Created by Shaul Robinov on 02/08/2018.
//  Copyright © 2018 Shaul Robinov. All rights reserved.
//
//Abstract class, must implement mthods decribed below.

#import "CardMatchingGame.h"

#import <UIKit/UIKit.h>

@class Deck;

/// View controller for card game.
@interface CardGameViewController : UIViewController

- (Deck *)createDeck;

/// Creates a game instance with given deck that holds \c count cards.
- (CardMatchingGame *)createGameWith:(NSUInteger)count cardsUsingDeck:(Deck *)deck; 

- (UIImage *)backgroundImageForCard:(Card *)card;

- (void)updateChosenCardUI:(UIButton *)cardButton :(Card *)card;

@end

