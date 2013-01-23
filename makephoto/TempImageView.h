//
//  TempImageView.h
//  makephoto
//
//  Created by 张 世杰 on 13-1-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TempImageView : UIView{
    NSInteger count;
}
@property (strong,nonatomic) UIImage *mImage;

- (void) insertImage:(UIImage *) image;

@end
