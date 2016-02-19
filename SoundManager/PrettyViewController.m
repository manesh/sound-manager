//
//  PrettyViewController.m
//  SoundManager
//
//  Created by Michael Manesh on 2/19/16.
//  Copyright © 2016 Michael Manesh. All rights reserved.
//

#import "PrettyViewController.h"

#import "MasterViewController.h"
#import "SoundManager.h"

@interface PrettyViewController ()

@property (nonatomic, weak) NSArray *filenames;

@end

@implementation PrettyViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Normal" style:UIBarButtonItemStylePlain target:self action:@selector(normalInterface:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound-manager-logo"]];
    self.navigationItem.titleView = titleView;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // red mage red
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:193./255 green:39./255 blue:45./255 alpha:1];
    
    // red mage mid-red
    self.collectionView.backgroundColor = [UIColor colorWithRed:125./255 green:25./255 blue:29./255 alpha:1];
    
    // load sounds if they are not loaded already
    if (![[SoundManager sharedManager] soundsPreloaded])
    {
        // let the manager know where to find the sound files we want loaded
        [[SoundManager sharedManager] setSoundsDirectory:@"Sounds"];
        self.filenames = [[SoundManager sharedManager] sounds];
        
        [[SoundManager sharedManager] preloadSounds:^{
            // update cells to make interactive when preloading finishes
            // TODO: update cells one-by-one as they become ready to play
            [self.collectionView reloadData];
        }];
    }
    
}

- (void)normalInterface:(UIBarButtonItem *)button
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MasterViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    [self.navigationController setViewControllers:@[viewController] animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.filenames count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
