//
//  PageScrollView.m
//  makephoto
//
//  Created by 张 世杰 on 12-12-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PageScrollView.h"




typedef enum{
    HGPageScrollViewUpdateMethodInsert, 
    HGPageScrollViewUpdateMethodDelete, 
    HGPageScrollViewUpdateMethodReload
}PageScrollViewUpdateMethod;


@interface PageScrollView()


// initializing/updating controls
- (void) initHeaderForPageAtIndex : (NSInteger) index;
- (void) initDeckTitlesForPageAtIndex : (NSInteger) index;

// insertion/deletion/update of pages
- (PageView*) loadPageAtIndex:(NSInteger)index insertIntoVisibleIndex:(NSInteger) visibleIndex;
- (void) addPageToScrollView : (PageView *) page atIndex : (NSInteger) index;
- (void) insertPageInScrollView:(PageView *)page atIndex:(NSInteger) index animated:(BOOL)animated;
- (void) removePagesFromScrollView:(NSArray*)pages animated:(BOOL)animated;
- (void) setFrameForPage:(UIView*)page atIndex:(NSInteger)index;
- (void) shiftPage : (UIView*) page withOffset : (CGFloat) offset;
- (void) setNumberOfPages : (NSInteger) number; 
- (void) updateScrolledPage : (PageView*) page index : (NSInteger) index;
- (void) prepareForDataUpdate : (PageScrollViewUpdateMethod) method withIndexSet : (NSIndexSet*) set;


// managing selection and scrolling
- (void) updateVisiblePages;
- (void) setAlphaForPage : (UIView*) page;
- (void) setOpacity:(CGFloat)alpha forObstructionLayerOfPage:(UIView *)page;
- (void) preparePage : (PageView *) page forMode : (PageScrollViewMode) mode; 
- (void) setViewMode:(PageScrollViewMode)mode animated:(BOOL)animated; //toggles selection/deselection

@end


@implementation PageScrollView

@synthesize numberOfPages,pageControl,scrollView;

- (id)initWithFrame:(CGRect)frame
{
//    if (frame) {
//        self.frame=frame;
//    }
    if ((self = [super initWithFrame: frame]))
	{
//		self.backgroundColor = [UIColor clearColor] ;
	}

    numberOfPages=1;
//    setup views 
    CGRect gframe=CGRectMake(frame.origin.x, frame.origin.y+20, frame.size.width, frame.size.height-60);

//setup scrollview
    scrollView=[[ UIScrollView alloc] initWithFrame:gframe];
    scrollView.decelerationRate=1.0;
    scrollView.delaysContentTouches=NO;
    scrollView.clipsToBounds=NO;
    scrollView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [scrollView setCanCancelContentTouches:NO];
    scrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scrollView.scrollEnabled=YES;
    scrollView.pagingEnabled=YES;
    scrollView.directionalLockEnabled=NO;
    scrollView.alwaysBounceVertical=NO;
    scrollView.alwaysBounceHorizontal=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    
//    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(50, 50, 50, 10)];
//    label1.text=@"1111111";
//    [scrollView insertSubview:label1 atIndex:0];
//    
//    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(scrollView.frame.size.width + 50, 50, 50, 10)];
//    label2.text=@"2222222";
//    [scrollView insertSubview:label2 atIndex:1];
//    
//    scrollView.contentSize= CGSizeMake( scrollView.frame.size.width*2, scrollView.frame.size.height);
    
    [scrollView setBackgroundColor:[UIColor orangeColor]];
    
    [self addSubview:scrollView];
    //setup pagecontrol
    
//    NSLog([NSString stringWithFormat:@"%d",gframe.origin.y]);
    
    CGRect FrameOfPageControl=CGRectMake(160,gframe.origin.y+gframe.size.height+20, 0, 30);
    self.pageControl=[[UIPageControl alloc]initWithFrame:FrameOfPageControl ];
    self.pageControl.backgroundColor=[UIColor blackColor];
    self.pageControl.numberOfPages=1;
    self.pageControl.currentPage=0;
    
    NSLog([NSString stringWithFormat: @"%d",self.pageControl.numberOfPages]);
    [self.pageControl addTarget:self action:@selector(didChangePageVale:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    
    return self;
}


- (void) insertPagesAtIndexs:(UIView *)addedView WithOriginX:(CGFloat )CX withIndex:(NSInteger *)indexs animated:(BOOL)animals
{
    NSLog(@"insert .....PagesAtIndexs!");
    if(addedView !=nil)
    {
        CGRect rect=scrollView.frame;
        rect.size.height=scrollView.frame.size.height;
        rect.size.width=scrollView.frame.size.width;
        rect.origin.x=CX;
        rect.origin.y=0;
        addedView.frame=rect;
        addedView.contentMode=UIViewContentModeScaleAspectFill;
        
        [scrollView insertSubview:addedView atIndex:indexs];
        cx+=scrollView.frame.size.width;
        numberOfPages++;
    
        [scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
    }
}

- (void) addIndexAtPageControl
{
//    pageControl.numberOfPages=pageControl.numberOfPages+1;
    self.pageControl.numberOfPages++;
    
//    NSLog([NSString stringWithFormat: @"%d" ,pageControl.numberOfPages]);
}
    

- (void) removeIndexAtPageControl
{
    self.pageControl.numberOfPages--;
}


//- (void) deletePagesAtIndexs:(NSIndexSet *)indexs animaated:(BOOL)animals
//{
//    
//    [[scrollView.subviews objectAtIndex:indexs] removeFromSuperview];
//    numberOfPages--;
//}



@end
