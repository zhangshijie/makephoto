//
//  DrawSomethingViewController.h
//  makephoto
//
//  Created by 张 世杰 on 12-12-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPUserResizableView.h"
#import "FinishDrawingViewController.h"
#import "UILabel+VerticalAlign.h"
#import "PageScrollView.h"
#import "PreviewViewController.h"
#import "TempImageView.h"
#import "SinaWeibo.h"
#import "TableViewController.h"
#import "PPRevealSideviewController.h"

/**将下面注释取消，并定义自己的app key，app secret以及授权跳转地址uri
 此demo即可编译运行**/

#define kAppKey             @"1568829609"
#define kAppSecret          @"e83fc2b56c4fcb8efcf7df37d0b92615"
#define kAppRedirectURI     @"http://freejoin.sinaapp.com"

#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif


@interface DrawSomethingViewController : UIViewController <UIGestureRecognizerDelegate, SPUserResizableViewDelegate,UIScrollViewDelegate,SinaWeiboDelegate, SinaWeiboRequestDelegate> {
    SPUserResizableView *currentlyEditingView;
    SPUserResizableView *lastEditedView;
    
    NSInteger currentNum;
    PreviewViewController *myPreviewViewContorller;
    UIView *currentBoradView;
    SinaWeibo *sinaweibo;
    NSDictionary *userInfo;
    NSArray *statuses;
    NSString *postStatusText;
    NSString *postImageStatusText;
    TempImageView *mTempImageView;
    
    CGFloat _offset;
    
    BOOL _animated;
}

@property (nonatomic,strong) NSMutableString *SelectedString;
@property (nonatomic,strong) SPUserResizableView *boraderview;
@property (nonatomic,strong) NSMutableArray *InsideImageViews,*InsideUserResizableView,*AllInsideUserResizableView;
@property (nonatomic,strong) NSMutableArray *ImageURLs;
@property (nonatomic,strong) NSMutableDictionary *CGRectsOfSPUserResizableViews;
@property (nonatomic,assign) NSInteger backsignal,BACKfromNAVIGATION,BACKfromCHOOSE,BACKfromWrite;
@property (nonatomic,strong) UIImageView *CurrentImageView;
@property (nonatomic,assign) NSInteger TheTag;
@property (nonatomic,strong) NSMutableString *CurrentInput;
@property (nonatomic,strong) PageScrollView *myPageScrollView;
@property (nonatomic,strong) NSMutableArray *boraderViews;
//@property (nonatomic,strong) SinaWeibo *sinaweibo;



-(void)readImageFromDocuments;
-(void) swapScrollViewsSubviewsToPre: (NSInteger )num  With : (NSInteger )sum  inScrollViewsSubviews :(NSArray *)Subviews;



- (IBAction)addNewPage:(id)sender;
- (IBAction)removeCurrentPage:(id)sender;

- (void) selectRightAction:(id)sender;

@end
