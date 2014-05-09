//
//  MGViewController.m
//  QuickViewHookupSourceCode
//
//  Created by person on 5/9/14.
//  Copyright (c) 2014 PP. All rights reserved.
//

#import "QQHookupViewController.h"

@interface QQHookupViewController ()
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UISwitch *switcher;
@property (nonatomic, strong) UIView *controllerContainerView;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UITapGestureRecognizer *hideControllerViewGesture;
@property (nonatomic, assign) BOOL controllerViewHidden;
@end

@implementation QQHookupViewController

- (instancetype)init
{
  self = [super initWithNibName:nil bundle:nil];
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  _switcher = [[UISwitch alloc] initWithFrame:CGRectZero];
  [_switcher sizeToFit];
  _switcher.frame = (CGRect) {{10, 10}, _switcher.bounds.size};
  [_switcher addTarget:self action:@selector(_switchDidChange:) forControlEvents:UIControlEventValueChanged];

  _slider = [[UISlider alloc] initWithFrame:CGRectZero];
  [_slider sizeToFit];
  _slider.frame = (CGRect) {{CGRectGetMaxX(_switcher.frame) + 10, CGRectGetMidY(_switcher.frame) - CGRectGetMidY(_slider.bounds)}, {CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(_switcher.frame) - 20, CGRectGetHeight(_slider.bounds)}};
  [_slider addTarget:self action:@selector(_sliderDidChange:) forControlEvents:UIControlEventValueChanged];

  CGFloat maxHeight = MAX(CGRectGetHeight(_switcher.bounds), CGRectGetHeight(_switcher.bounds)) + 20;
  _controllerContainerView = [[UIView alloc] initWithFrame:(CGRect){{0, CGRectGetHeight(self.view.bounds) - maxHeight}, {CGRectGetWidth(self.view.bounds), maxHeight}}];
  [_controllerContainerView addSubview:_switcher];
  [_controllerContainerView addSubview:_slider];
  _controllerContainerView.backgroundColor = [UIColor colorWithRed:0.62 green:0.78 blue:1 alpha:0.1];

  _slider.hidden = _sliderDidChange == nil;
  _switcher.hidden = _switchDidChange == nil;

  _hideControllerViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_hideAndShowControlerView:)];
  [_controllerContainerView addGestureRecognizer:_hideControllerViewGesture];
  [self.view addSubview:_controllerContainerView];
}

- (void)dealloc
{
  [_hideControllerViewGesture removeTarget:self action:@selector(_hideAndShowControlerView:)];
}

#pragma mark - Slider Configuration
- (void)setMaxSliderValue:(CGFloat)maxSliderValue
{
  _slider.maximumValue = maxSliderValue;
}

- (void)setMinSliderValue:(CGFloat)minSliderValue
{
  _slider.minimumValue = minSliderValue;
}

- (void)setSliderValue:(CGFloat)sliderValue
{
  _slider.value = sliderValue;
}

- (CGFloat)maxSliderValue
{
  return _slider.maximumValue;
}

- (CGFloat)minSliderValue
{
  return _slider.minimumValue;
}

- (CGFloat)sliderValue
{
  return _slider.value;
}

#pragma mark - Public method
- (void)setSliderDidChange:(QQSliderDidChange)sliderDidChange
{
  _sliderDidChange = [sliderDidChange copy];
  _slider.hidden = _sliderDidChange == nil;
}

- (void)setSwitchDidChange:(QQSwitchDidChange)switchDidChange
{
  _switchDidChange = [switchDidChange copy];
  _switcher.hidden = _switchDidChange == nil;
}

- (void)addContainerview:(UIView *)containerView withSize:(CGSize)size
{
  if (_containerView != containerView) {
    [_containerView removeFromSuperview];
    _containerView = containerView;
    [self.view insertSubview:_containerView belowSubview:_controllerContainerView];
    _containerView.frame = (CGRect){CGPointZero, size};
  }
}

#pragma mark - Target/Action
- (void)_sliderDidChange:(UISlider *)slider
{
  if (self.sliderDidChange) {
    self.sliderDidChange(slider.value);
  }
}

- (void)_switchDidChange:(UISwitch *)switcher
{
  if (self.switchDidChange) {
    self.switchDidChange(switcher.on);
  }
}

- (void)_hideAndShowControlerView:(UITapGestureRecognizer *)tap
{
  if (tap.state == UIGestureRecognizerStateRecognized) {
    [UIView animateWithDuration:0.2 animations:^{
      CGRect frame = _controllerContainerView.frame;
      if (_controllerViewHidden) {
        frame.origin.y -= CGRectGetHeight(frame) / 2;
      } else {
        frame.origin.y += CGRectGetHeight(frame) / 2;
      }
      _controllerContainerView.frame = frame;
    } completion:^(BOOL finished) {
      _controllerViewHidden = !_controllerViewHidden;
    }];
  }
}

- (BOOL)prefersStatusBarHidden
{
  return YES;
}
@end
