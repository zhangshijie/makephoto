//
//  PreviewViewController.m
//  makephoto
//
//  Created by 张 世杰 on 13-1-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "PreviewViewController.h"

@interface PreviewViewController ()

@end

@implementation PreviewViewController

@synthesize scrollview,imageToUpload;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id) init
{
    imageToUpload= [[UIImageView alloc] init];
    
    self.title=@"预览";
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect frame= CGRectMake(0, 0, 320, 480);
    scrollview = [[UIScrollView alloc]initWithFrame:frame];
    scrollview.backgroundColor=[UIColor brownColor];
    scrollview.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    scrollview.scrollEnabled=YES;
    [self.view addSubview:scrollview];

    
    
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillDisappear:(BOOL)animated
{
    for (UIView *view in scrollview.subviews) {
        [view removeFromSuperview];
    }
}

//- (void) selectRightAction
//{
////    [self initSinaWeibo];   
//
//    NSLog(@"hello");
//}

@end
