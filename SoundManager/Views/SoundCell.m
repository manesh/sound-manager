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
}

- (void)startPlayingAnimation
{
    NSArray *frames = @[[UIImage imageNamed:@"audio-1"],
                        [UIImage imageNamed:@"audio-2"],
                        [UIImage imageNamed:@"audio-3"],
                        [UIImage imageNamed:@"audio-4"]];
    
    self.audioRainbow.animationImages = frames;
    self.audioRainbow.animationRepeatCount = 0;
    self.audioRainbow.animationDuration = 0.5;
    [self.audioRainbow startAnimating];

}

- (void)stopPlayingAnimation
{
    [self.audioRainbow stopAnimating];
    self.audioRainbow.image = [UIImage imageNamed:@"audio-0"];
}

@end
