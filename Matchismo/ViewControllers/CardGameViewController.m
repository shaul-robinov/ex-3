//
//  ViewController.m
//  Matchismo
//
//  Created by Shaul Robinov on 02/08/2018.
//  Copyright © 2018 Shaul Robinov. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

//The deck used in the game.
@property (strong, nonatomic) Deck *deck;

//The game being played.
@property (strong, nonatomic) CardMatchingGame *game;

//String that holds all the moves done in the game.
@property (strong, nonatomic) NSMutableAttributedString* history;

//Array of buttons displayed to the user as cards.
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

//Label displays the result of the last move.
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

//Label displays the score of the game.
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"Show History"]) {
    if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
      HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
      [hvc updateHistoy: self.history];
    }
  }
}

- (void)viewDidLoad {
  self.resultLabel.numberOfLines = 0;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (Deck *)deck {
  if(!_deck){
    _deck = [self createDeck];
  }
  return _deck;
}

- (NSMutableAttributedString *)history {
  if(!_history) {
    _history = [[NSMutableAttributedString alloc] initWithString:@""];
  }
  return _history;
}

- (Deck *)createDeck {
  return nil;
}

- (CardMatchingGame *)game {
  if(!_game) {
    _game = [self createGameWith:self.cardButtons.count cardsUsingDeck:self.deck];
  }
  return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSUInteger chosenCardIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenCardIndex];
  [self updateUI];
}

- (void)updateUI {
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.resultLabel.attributedText = [self getAttributedResultLabel];
  [self updateHistory];
  for(UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [self updateChosenCardUI:cardButton :card];
    cardButton.enabled = !card.isMatched;
  }
  
}

- (NSAttributedString *)getAttributedResultLabel {
  if(!self.game.label.length) {
    return [[NSAttributedString alloc] initWithString:@""];
  }
  NSMutableAttributedString *mutableLabel = [[NSMutableAttributedString alloc] initWithString:@""];
  NSAttributedString *attributedLabel = [[NSAttributedString alloc] initWithString:self.game.label];
  for(Card* chosenCard in [self.game getChosenCards]) {
    if(chosenCard.isChosen  || !chosenCard.isMatched) {
      [mutableLabel appendAttributedString:[self getCardContentWithAttributes:chosenCard]];
    }
  }
  [mutableLabel appendAttributedString:attributedLabel];
  return mutableLabel;
}

- (NSAttributedString *)getCardContentWithAttributes:(Card *)card {
  return [[NSAttributedString alloc] initWithString:card.contents attributes:[card attributes]];
}

- (void)updateHistory {
  if (!self.game.label.length) {
    return;
  }
  [self.history appendAttributedString:[self getAttributedResultLabel]];
  NSAttributedString* breakLine = [[NSAttributedString alloc] initWithString:@"\n"];
  [self.history appendAttributedString: breakLine];
}

- (IBAction)dealGame:(UIButton *)sender {
  self.game = nil;
  self.deck = nil;
  self.history = [[NSMutableAttributedString alloc] initWithString:@""];
  [self updateUI];
}

//Abstract method.
- (CardMatchingGame *)createGameWith:(NSUInteger)count cardsUsingDeck:(Deck *)deck {
  return nil;
}

//Abstract method.
- (UIImage *)backgroundImageForCard:(Card *)card {
  return nil;
}

//Abstract method.
- (void)updateChosenCardUI:(UIButton *)cardButton :(Card *)card {
  return;
}

@end
