//
//  ViewController.m
//  JYXDACircularProgressDemo
//
//  Created by JI Yixuan on 10/17/15.
//  Copyright © 2015 iamjiyixuan. All rights reserved.
//

#import "ViewController.h"

// 3rd
#import <DACircularProgress/DACircularProgressView.h>
#import <Masonry/Masonry.h>

CGSize const kCircularProgressViewSize = {50.0f, 50.0f};

UIColor * const kJYXLightBlueColor(CGFloat alpha)
{
    return [UIColor colorWithRed:0.32f green:0.65f blue:0.98f alpha:alpha];
}

@interface ViewController ()

@property (nonatomic, assign) NSInteger progress;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) DACircularProgressView *circularProgressView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add subviews
    [self.view addSubview:self.circularProgressView];
    [self.view addSubview:self.button];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // layout subviews
    [self.circularProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(kCircularProgressViewSize);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    [self.button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width - 20 * 2, 40.0f));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20.0f);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)jyx_timerFired:(id)sender
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    self.circularProgressView.progress = self.progress / 100.0f;
    
    self.progress += 20;
    
    [self.circularProgressView setProgress:(self.progress / 100.0f) animated:YES initialDelay:0.0f withDuration:1.0f];
    
    if (self.progress == 100) {
        [self.timer invalidate];
        NSLog(@"timer invalidate ... ");
        self.timer = nil;
    }
}

- (void)jyx_buttonTapped:(id)sender
{
    if (self.progress == 100) {
        self.progress = 0;
        self.circularProgressView.progress = self.progress / 100.0f;
    }
    
    [self.timer fire];
    NSLog(@"timer fire ... ");
}

#pragma mark - Getters & Setters

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(jyx_timerFired:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (DACircularProgressView *)circularProgressView
{
    if (!_circularProgressView) {
        _circularProgressView = [[DACircularProgressView alloc] init];
        _circularProgressView.trackTintColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
        _circularProgressView.progressTintColor = kJYXLightBlueColor(1.0f);
        _circularProgressView.thicknessRatio = 0.05;
        _circularProgressView.roundedCorners = 1;
    }
    return _circularProgressView;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc] init];
        _button.layer.borderColor = kJYXLightBlueColor(1.0f).CGColor;
        _button.layer.borderWidth = 1;
        _button.layer.cornerRadius = 20.0f;
        [_button setTitle:@"Button" forState:UIControlStateNormal];
        [_button setTitleColor:kJYXLightBlueColor(1.0f) forState:UIControlStateNormal];
        [_button setTitleColor:kJYXLightBlueColor(0.75f) forState:UIControlStateHighlighted];
        [_button addTarget:self action:@selector(jyx_buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
