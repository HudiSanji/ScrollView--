//
//  HdScrollView.h
//  ScrollView
//
//  Created by Hu Di on 13-10-11.
//  Copyright (c) 2013年 Sanji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDPageControl.h"
@class HDScrollview;
@protocol HDScrollviewDelegate <NSObject>
-(void)TapView:(HDScrollview *)scrollview AtIndex:(int)index;
@end

@interface HDScrollview : UIScrollView<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSMutableArray *ContentViews;
@property (nonatomic,assign) BOOL loop;
@property (nonatomic,strong) HDPageControl *pagecontrol;
@property (nonatomic,assign) NSInteger currentPageIndex;
@property (assign,nonatomic) id<HDScrollviewDelegate> HDdelegate;
/**
 *	@brief	不循环
 */
-(id)initWithFrame:(CGRect)frame withContentViews:(NSMutableArray *)contentViews;

/**
 *	@brief	循环滚动
 */
-(id)initLoopScrollWithFrame:(CGRect)frame withContentViews:(NSMutableArray *)contentViews;
-(void)HDscrollViewDidScroll;
-(void)HDscrollViewDidEndDecelerating;
-(void)pageTurn:(UIPageControl *)sender;
@end



