//
//  PageView.m
//  makephoto
//
//  Created by 张 世杰 on 12-12-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PageView.h"

@implementation PageView

@synthesize identityFrame,reuseIdentifier;

- (id) initWithCoder:(NSCoder *)aDecoder
{    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code.
        _identityFrame = self.frame; //as it is defined in the XIB
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

- (void)dealloc {
//    [super dealloc];
}



- (void)prepareForReuse;
{
	//reset modified properties
	self.transform = CGAffineTransformIdentity;
}

@end
