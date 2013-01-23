//
//  FinishDrawingViewController.h
//  makephoto
//
//  Created by 张 世杰 on 12-12-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawSomethingViewController.h"
@interface FinishDrawingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *FinishedImageView;

@property (nonatomic,strong) UIImage *finishedImage;

@property (nonatomic,strong) UIScrollView *scroll;



@end
