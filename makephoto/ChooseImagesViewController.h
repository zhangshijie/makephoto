//
//  ChooseImagesViewController.h
//  makephoto
//
//  Created by 张 世杰 on 12-12-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridViewDelegate.h"
#import "UIGridView.h"
#import "Cell.h"
//#import "PageScrollView.h"

@interface ChooseImagesViewController : UIViewController<UIGridViewDelegate>

@property (strong, nonatomic) IBOutlet UIGridView *table;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic ,assign) int i;
//@property (nonatomic,strong) PageScrollView *myPageScrollView;

-(NSMutableArray *)readImageFromDocuments:(NSInteger ) mount ;

@end
