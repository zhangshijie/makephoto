//
//  ChooseImagesViewController.m
//  makephoto
//
//  Created by 张 世杰 on 12-12-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChooseImagesViewController.h"
#import "DrawSomethingViewController.h"
@interface ChooseImagesViewController ()

@end

@implementation ChooseImagesViewController
@synthesize table,images,i;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    
     images=[self readImageFromDocuments :13];
//    UIGridView  *gridview=[UIGridView alloc]ini
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}


- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
  	return 80;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
//    NSLog(@"heightForRowAt");
	return 80;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
	return 4;
}


- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
	return 20;
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
	Cell *cell = (Cell *)[grid dequeueReusableCell];
	
	if (cell == nil) {
		cell = [[Cell alloc] init];
	}
//	 NSLog([@"imageCount" stringByAppendingString:[NSString stringWithFormat:@"%d",[images count]]]);
    
//    NSLog([NSString stringWithFormat:@"%d",[images count]]);
    
    if((rowIndex*4+columnIndex)>=[images count]){
        i=[images count]-1;
    }else{
        i=rowIndex*4+columnIndex;
    }
    
//    NSLog([NSString stringWithFormat:@"%d",i ]);
    
    UIImage *img= [UIImage imageWithContentsOfFile:[images objectAtIndex:i]];
    
    [cell.view setImage:img];
	
	return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
	NSLog(@"%d, %d clicked", rowIndex, colIndex);

    PPRevealSideViewController *mPPRevealSideViewController=self.presentingViewController;
    
    
    UINavigationController  *navigation=mPPRevealSideViewController.rootViewController;
    
    DrawSomethingViewController *viewcontroller=[navigation.viewControllers objectAtIndex:0];
    
    viewcontroller.SelectedString=[images objectAtIndex:(rowIndex*4+colIndex)];

    viewcontroller.backsignal=viewcontroller.BACKfromCHOOSE;
    
//    NSLog(viewcontroller.SelectedString);
    
    
    
    [self dismissModalViewControllerAnimated:YES];
}


-(NSMutableArray *)readImageFromDocuments:(NSInteger ) mount 
{
    

    NSMutableArray *Images=[NSMutableArray arrayWithCapacity:mount];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,                                                                          NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    for (int i=0; i<mount; i++) {
        
        NSString *filePath2 = [documentsDirectory stringByAppendingPathComponent:[[NSString stringWithFormat:@"%d",i+1] stringByAppendingString:@".jpg"]];
        
        
        [Images addObject:filePath2];

    }

    return  Images;
}   


@end
