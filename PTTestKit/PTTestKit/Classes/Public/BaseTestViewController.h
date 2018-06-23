//
//  BaseTestViewController.h
//  EffectiveOCDemo
//
//  Created by aron on 2017/4/18.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ActionCellModel : NSObject

@property (nonatomic, copy) NSString* actionName;
@property (nonatomic, copy) void(^actionCallBack)(void);

-(instancetype)initWithActionName:(NSString*)actionName actionCallBack:(void(^)(void))callback;

@end


@interface BaseTestViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView* tableView;

- (void)addActionWithName:(NSString*)actionName callback:(void(^)(void))callback;

@end
