//
//  SoundCell.h
//  SoundManager
//
//  Created by Michael Manesh on 2/19/16.
//  Copyright © 2016 Michael Manesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoundCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *soundName;
@property (weak, nonatomic) IBOutlet UIView *outerCircle;
@property (weak, nonatomic) IBOutlet UIView *innerCircle;

@end
