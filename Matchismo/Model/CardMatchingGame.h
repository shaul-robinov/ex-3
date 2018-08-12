// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shaul Robinov.

#import <Foundation/Foundation.h>

#import "Deck.h"
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

/// A class representing a card matching game.
@interface CardMatchingGame : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Initializes game with given deck that holds \c count cards
/// and \c kMatch cards are needed for a match.
- (instancetype)initWithCardCount:(NSUInteger)count
      usingDeck:(Deck *)deck withKMatching:(NSUInteger)kMatch NS_DESIGNATED_INITIALIZER;

/// Chooses a card at given index.
- (void)chooseCardAtIndex:(NSUInteger)index;

/// Returnes the card from given index.
- (Card *)cardAtIndex:(NSUInteger)index;

/// Returns an array of cards that are currently chosen.
- (NSArray *)getChosenCards;

/// The current score in the game.
@property (readonly, nonatomic) NSInteger score;

/// The label to be displayed to the user indicating
/// the result of his last move.
@property (readonly, nonatomic) NSString *label;

/// Number of cards required for a match.
@property (readonly, nonatomic) NSUInteger kMatchGame;

@end

NS_ASSUME_NONNULL_END
