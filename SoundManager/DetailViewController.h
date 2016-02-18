//
//  DetailViewController.h
//  SoundManager
//
//  Created by Michael Manesh on 2/18/16.
//  Copyright © 2016 Michael Manesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

