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

@end
