//
//  LeftViewController.h
//  PPRevealSideViewController
//
//  Created by Marian PAUL on 16/02/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawSomethingViewController.h"

@class DrawSomethingViewController;

@interface TableViewController : UITableViewController
{
    DrawSomethingViewController *currentDrawSomethingViewController;
}
//@property (nonatomic,strong) DrawSomethingViewController currentDrawSomethingViewController;

- (id)initWithStyleAndDrawSomething:(UITableViewStyle)style with:(DrawSomethingViewController *) mDrawSomethingViewController;

@end
