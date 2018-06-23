//
//  PTViewController.m
//  PTTestKit
//
//  Created by flypigrmvb on 11/13/2017.
//  Copyright (c) 2017 flypigrmvb. All rights reserved.
//

#import "PTViewController.h"
#import <PTTestKit/PublicFile.h>
// ！！private header 可以导入
#import <PTTestKit/PrivateFile.h>
// ！！报错
//#import <PTTestKit/ProjectFile.h>

@interface PTViewController ()

@end

@implementation PTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addActionWithName:@"Test" callback:^{
        NSLog(@"====");
    }];
    
    [self addActionWithName:@"PrivateFile" callback:^{
        [PrivateFile test];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [PrivateFile test];
}

@end
