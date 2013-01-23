//
//  ImagesCategoryViewController.h
//  makephoto
//
//  Created by 张 世杰 on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagesCategoryViewController : UITableViewController

- (IBAction)BackButtonOnClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UITableViewCell *Cell1;
@property (strong, nonatomic) IBOutlet UITableViewCell *Cell2;
@end
