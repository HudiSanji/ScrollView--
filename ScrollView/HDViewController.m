//
//  CSIIViewController.m
//  ScrollView
//
//  Created by Hu Di on 13-10-11.
//  Copyright (c) 2013年 Sanji. All rights reserved.
//

#import "HDViewController.h"

@interface HDViewController ()
{
    NSMutableArray *imageArray;
    HDScrollview *_scrollview;
}
@end

@implementation HDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageArray=[NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    CGRect bound=CGRectMake(0, 0, 320, 150);
    NSArray *color=[[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor brownColor],[UIColor blueColor],[UIColor lightGrayColor], nil];
//    for (int i=0; i<color.count; i++) {
//        UIImageView *imageview=[[UIImageView alloc]init];
//        imageview.backgroundColor=[color objectAtIndex:i];
//        [imageArray addObject:imageview];
//    }
    NSArray *ImageArr=@[[UIImage imageNamed:@"Expression_1"],[UIImage imageNamed:@"Expression_2"],[UIImage imageNamed:@"Expression_3"],[UIImage imageNamed:@"Expression_4"]];
    for (int i=0; i<ImageArr.count; i++) {
        UIView *backgrounView=[[UIView alloc]init];
        backgrounView.backgroundColor=[color objectAtIndex:i];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(160, 40, 60, 60)];
        imageview.image=[ImageArr objectAtIndex:i];
        imageview.contentMode=UIViewContentModeScaleAspectFit;
        [backgrounView addSubview:imageview];
        //可以自定义imageview
        if (i%3==0) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(50, 40, 60, 30);
            NSString *title=[NSString stringWithFormat:@"按钮%d",i];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(BTNCLICK:) forControlEvents:UIControlEventTouchDown];
            [backgrounView addSubview:btn];
        }
        else if(i%3==1)
        {
            UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(50, 40, 60, 20)];
            textField.borderStyle=UITextBorderStyleRoundedRect;
            [backgrounView addSubview:textField];
        }
        else if(i%3==2)
        {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 40, 60, 20)];
            label.backgroundColor=[UIColor redColor];
            label.text=@"label";
            [backgrounView addSubview:label];
        }
        [imageArray addObject:backgrounView];
    }
    //_scrollview=[[HDScrollview alloc]initWithFrame:bound withContentViews:imageArray];
    _scrollview=[[HDScrollview alloc]initLoopScrollWithFrame:bound withContentViews:imageArray];
    _scrollview.delegate=self;
    _scrollview.HDdelegate=self;
    [self.view addSubview:_scrollview];
    _scrollview.pagecontrol.frame=CGRectMake(0, _scrollview.frame.origin.y+_scrollview.frame.size.height-10, 320, 10);
    _scrollview.pagecontrol.currentcolor=[UIColor blackColor];
    _scrollview.pagecontrol.othercolor=[UIColor whiteColor];
    _scrollview.pagecontrol.currentPage=0;
    [self.view addSubview:_scrollview.pagecontrol];
    NSLog(@"");
}

-(void)viewDidAppear:(BOOL)animated
{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)BTNCLICK:(UIButton *)sender
{
}
#pragma mark ==========UIScrollViewDelegate============
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [_scrollview HDscrollViewDidScroll];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    
    [_scrollview HDscrollViewDidEndDecelerating];
}
#pragma mark ==========HDScrollviewDelegate============
-(void)TapView:(HDScrollview *)scrollview AtIndex:(int)index
{
    NSLog(@"点击了第%d个页面",index);
    //下面可以根据自己的需求操作
    //Example
    if (imageArray.count>1) {
        //删除一个
        [imageArray removeObjectAtIndex:index];
        //_scrollview=[_scrollview initWithFrame:_scrollview.frame withImageView:imageArray];
        _scrollview.loop=YES;
        _scrollview.ContentViews=imageArray;
        _scrollview.pagecontrol.currentPage=index;
        
    }
}
@end
