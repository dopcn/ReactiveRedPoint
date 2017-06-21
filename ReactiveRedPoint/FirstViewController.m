//
//  FirstViewController.m
//  ReactiveRedPoint
//
//  Created by 纬洲 冯 on 16/06/2017.
//  Copyright © 2017 fengweizhou. All rights reserved.
//

#import "FirstViewController.h"
#import "RedPoint.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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
    
    UIView *tab = [self.tabBarController.tabBar.selectedItem valueForKeyPath:@"_view._info"];
    for (int i = 1; i < 8; i++) {
        UIView *view = [self.view viewWithTag:i];
        if (i == 1) {
            [view.redpoint updateValue:-1];
        } else {
            [view.redpoint updateValue:i];
        }
        UIGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:gr];
        [tab.redpoint appendChild:view.redpoint];
    }
}

- (void)tap:(UITapGestureRecognizer *)gr {
    UIView *view = gr.view;
    [view.redpoint hit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
