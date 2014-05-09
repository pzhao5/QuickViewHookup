//
//  QuickViewHookupSourceCode
//
//  Created by person on 5/9/14.
//  Copyright (c) 2014 PP. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^QQSliderDidChange) (CGFloat value);
typedef void(^QQSwitchDidChange) (BOOL value);

@interface QQHookupViewController : UIViewController

@property (nonatomic, assign) CGFloat maxSliderValue;
@property (nonatomic, assign) CGFloat minSliderValue;
@property (nonatomic, assign) CGFloat sliderValue;

@property (nonatomic, copy) QQSliderDidChange sliderDidChange;
@property (nonatomic, copy) QQSwitchDidChange switchDidChange;

- (void)addContainerview:(UIView *)containerView withSize:(CGSize)size;
@end
