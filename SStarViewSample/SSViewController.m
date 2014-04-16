//
//  SSViewController.m
//  SStarViewSample
//
//  Created by Six on 14-4-14.
//  Copyright (c) 2014年 Shingwa Six. All rights reserved.
//

#import "SSViewController.h"
#import "SStarView.h"

@interface SSViewController ()
@property (weak, nonatomic) IBOutlet SStarView *starView;
@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //_starView create by XIB
    {
        _starView.lineWidth = 2.0; //Set starView border width
        _starView.borderColor = [UIColor redColor]; //Set starView border color
    }
    
    //Create a 100px * 30px starView with code
    {
        SStarView *starView = [[SStarView alloc] initWithFrame:CGRectMake(50, 90, 100, 30)];
        [self.view addSubview:starView];
        starView.starCount = 2; //Set star number of starView
    }
    
    //Create a 200px * 60px width starView with code
    {
        SStarView *starView = [[SStarView alloc] initWithFrame:CGRectMake(50, 140, 200, 60)];
        [self.view addSubview:starView];
        starView.starCount = 4; //Set star number of starView,the max star count is 3
        starView.selectColor = [UIColor redColor]; //Set starView select color
    }
    
    //Create a 200px * 30px width starView with code
    {
        SStarView *starView = [[SStarView alloc] initWithFrame:CGRectMake(50, 220, 200, 30)];
        [self.view addSubview:starView];
        starView.starCount = 2; //Set star number of starView
        starView.maxStar = 4; // Set max star number of starView
        starView.minStar = 2; // Set min star number of starView
    }
    
    //Create a 220px * 30px width starView with code
    {
        SStarView *starView = [[SStarView alloc] initWithFrame:CGRectMake(50, 260, 220, 30)];
        [self.view addSubview:starView];
        starView.starCount = 5; //Set star number of starView
        starView.unSelectColor = [UIColor greenColor]; //Set starView unselect color
        starView.lineWidth = 0.0; //Set starView border width
        [starView setUserInteractionEnabled:NO]; //Disable droping starView
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
