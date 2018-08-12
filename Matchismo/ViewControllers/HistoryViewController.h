// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Shaul Robinov.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// History tab view controller.
@interface HistoryViewController : UIViewController

/// Updates the history with the last move that was done.
- (void)updateHistoy:(NSAttributedString *)history;

@end

NS_ASSUME_NONNULL_END
