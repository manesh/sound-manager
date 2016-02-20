//
//  SoundCell.m
//  SoundManager
//
//  Created by Michael Manesh on 2/19/16.
//  Copyright © 2016 Michael Manesh. All rights reserved.
//

#import "SoundCell.h"

@implementation SoundCell

- (void)layoutSubviews
{
    [super layoutSubviews]; // autolayout
    
    self.innerCircle.layer.cornerRadius = self.innerCircle.bounds.size.width/2.;
    self.outerCircle.layer.cornerRadius = self.outerCircle.bounds.size.width/2.;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self stopPlayingAnimation];
}

- (void)startPlayingAnimation
{
    [UIView animateKeyframesWithDuration:0.25
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionRepeat
                              animations:^{
                                     [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.125 animations:^{
                                         CGRect rect = CGRectInset(self.innerCircle.frame, 10, 10);
                                         self.innerCircle.frame = rect;
                                         self.innerCircle.layer.cornerRadius = rect.size.width/2.;
                                     }];
                                     [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.125 animations:^{
                                         CGRect rect = CGRectInset(self.innerCircle.frame, -10, -10);
                                         self.innerCircle.frame = rect;
                                         self.innerCircle.layer.cornerRadius = rect.size.width/2.;
                                     }];
                                 } completion:^(BOOL finished) {

                                 }];
}

- (void)stopPlayingAnimation
{
    [UIView animateKeyframesWithDuration:0.25
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionAutoreverse
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.125 animations:^{
                                      CGRect rect = CGRectInset(self.innerCircle.frame, 10, 10);
                                      self.innerCircle.frame = rect;
                                      self.innerCircle.layer.cornerRadius = rect.size.width/2.;
                                  }];
                                  [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.125 animations:^{
                                      CGRect rect = CGRectInset(self.innerCircle.frame, -10, -10);
                                      self.innerCircle.frame = rect;
                                      self.innerCircle.layer.cornerRadius = rect.size.width/2.;
                                  }];
                              } completion:^(BOOL finished) {
                                  
                              }];
}

@end
