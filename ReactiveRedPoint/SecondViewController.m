//
//  SecondViewController.m
//  ReactiveRedPoint
//
//  Created by 纬洲 冯 on 16/06/2017.
//  Copyright © 2017 fengweizhou. All rights reserved.
//

#import "SecondViewController.h"
#import "RedPoint.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat x = 20, y = 250, height = (UIScreen.mainScreen.bounds.size.width-40)/4-10;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, height, height)];
    view.backgroundColor = [UIColor greenColor];
    view.tag = 1;
    [self.view addSubview:view];
    x += (height+10);
    view = [[UIView alloc] initWithFrame:CGRectMake(x, y, height, height)];
    view.backgroundColor = [UIColor orangeColor];
    view.tag = 2;
    [self.view addSubview:view];
    x += (height+10);
    view = [[UIView alloc] initWithFrame:CGRectMake(x, y, height, height)];
    view.backgroundColor = [UIColor yellowColor];
    view.tag = 3;
    [self.view addSubview:view];
    x += (height+10);
    view = [[UIView alloc] initWithFrame:CGRectMake(x, y, height, height)];
    view.backgroundColor = [UIColor purpleColor];
    view.tag = 4;
    [self.view addSubview:view];
    
    x = 20;
    y += (height+10);
    view = [[UIView alloc] initWithFrame:CGRectMake(x, y, height*2+10, height)];
    view.backgroundColor = [UIColor blueColor];
    view.tag = 5;
    [self.view addSubview:view];
    x += (height*2+20);
    view = [[UIView alloc] initWithFrame:CGRectMake(x, y, height*2+10, height)];
    view.backgroundColor = [UIColor brownColor];
    view.tag = 6;
    [self.view addSubview:view];
    
    x = 20;
    y += (height+10);
    view = [[UIView alloc] initWithFrame:CGRectMake(x, y, height*4+30, height)];
    view.backgroundColor = [UIColor blackColor];
    view.tag = 7;
    [self.view addSubview:view];
    
    
    [[self.view viewWithTag:5].redpoint appendChild:[self.view viewWithTag:1].redpoint];
    [[self.view viewWithTag:5].redpoint appendChild:[self.view viewWithTag:2].redpoint];
    [[self.view viewWithTag:6].redpoint appendChild:[self.view viewWithTag:3].redpoint];
    [[self.view viewWithTag:6].redpoint appendChild:[self.view viewWithTag:4].redpoint];
    [[self.view viewWithTag:7].redpoint appendChild:[self.view viewWithTag:5].redpoint];
    [[self.view viewWithTag:7].redpoint appendChild:[self.view viewWithTag:6].redpoint];
    
    for (int i = 1; i < 5; i++) {
        UIView *view = [self.view viewWithTag:i];
        UIGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:gr];
    }
    
    [[self.view viewWithTag:1].redpoint updateValue:-1];
    [[self.view viewWithTag:2].redpoint updateValue:1];
    [[self.view viewWithTag:3].redpoint updateValue:2];
    [[self.view viewWithTag:4].redpoint updateValue:3];
}

- (void)tap:(UITapGestureRecognizer *)gr {
    UIView *view = gr.view;
    [view.redpoint hit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
