//
//  BaseTestViewController.m
//  EffectiveOCDemo
//
//  Created by aron on 2017/4/18.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "BaseTestViewController.h"

@implementation ActionCellModel

-(instancetype)initWithActionName:(NSString*)actionName actionCallBack:(void(^)(void))callback {
    if (self = [super init]) {
        _actionName = actionName;
        _actionCallBack = callback;
    }
    return self;
}

@end



@interface BaseTestViewController ()

@property (nonatomic, strong) NSMutableArray* actionCellModels;

@end

@implementation BaseTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];

    _actionCellModels = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addActionWithName:(NSString*)actionName callback:(void(^)())callback {
    ActionCellModel* model = [[ActionCellModel alloc] initWithActionName:actionName actionCallBack:^{
        !callback ?: callback();
    }];
    [_actionCellModels addObject:model];
}

#pragma mark - ......::::::: UITableViewDelegate :::::::......

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _actionCellModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    ActionCellModel* model = _actionCellModels[indexPath.row];
    cell.textLabel.text = model.actionName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActionCellModel* model = _actionCellModels[indexPath.row];
    !model.actionCallBack ?: model.actionCallBack();
}
@end
