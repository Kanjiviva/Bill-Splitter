//
//  TipOptionViewController.h
//  BillSplitter
//
//  Created by Steve on 2015-09-06.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TipOptionViewControllerDelegate <NSObject>

- (void)tipsPercentage:(NSString *)tips;

@end

@interface TipOptionViewController : UIViewController

@property (strong, nonatomic) id<TipOptionViewControllerDelegate> delegate;

@end
