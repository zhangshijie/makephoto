//
//  TempImageView.m
//  makephoto
//
//  Created by 张 世杰 on 13-1-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "TempImageView.h"

@implementation TempImageView

@synthesize mImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    count=0;
    mImage= [[UIImage alloc]init];
    self = [super initWithFrame:CGRectMake(0, 0, 300, 260)];
    return self;
}


- (void) insertImage:(UIImage *) image 
{
    UIImage *image1= self.mImage;
    
    UIGraphicsBeginImageContext(CGSizeMake(300, 260*(count+1)));
    
    self.frame = CGRectMake(0, 0, 300, 260*(count+1));
    
    CGRect tempRect = CGRectMake(0,0,300, self.frame.size.height-260);
    [image1 drawInRect:tempRect];
    
    CGRect tempRect1 = CGRectMake(0,self.frame.size.height-260,300, 260);
    [image drawInRect:tempRect1];
    mImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    count++;
}

@end
