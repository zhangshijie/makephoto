//
//  Cell.m
//  makephoto
//
//  Created by 张 世杰 on 12-12-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
	
    if (self = [super init]) {
		
        self.frame = CGRectMake(0, 0, 0, 0);
		
        self.view=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 75)];
        
        UIImage *image=[UIImage imageNamed:@"10.jpg"];
        
        [self.view setImage:image];
        
        
        
        [self addSubview:self.view];
        
      
        
		}
	
    return self;
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
