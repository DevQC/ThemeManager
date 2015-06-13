//
//  ViewController.m
//  ThemeManager
//
//  Created by Yanjun Zhuang on 14/6/15.
//  Copyright (c) 2015 Tencent. All rights reserved.
//

#import "ViewController.h"
#import "ThemeManager.h"
#import "UIView+Theme.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.data = @[@{@"title" : @"Classic", @"image" : @"browser"},
                  @{@"title" : @"Night", @"image" : @"files"},
                  @{@"title" : @"Classic", @"image" : @"hardware"},
                  @{@"title" : @"Night", @"image" : @"downloads"},
                  @{@"title" : @"Classic", @"image" : @"browser"},
                  @{@"title" : @"Night", @"image" : @"files"},
                  @{@"title" : @"Classic", @"image" : @"browser"},
                  @{@"title" : @"Night", @"image" : @"files"}
                  ];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        tableView;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *item = self.data[indexPath.row];
    NSString *imageName = item[@"image"];
    imageName = [NSString stringWithFormat:@"tabbar_%@", imageName];
    
    cell.textLabel.text = item[@"title"];
    
    // Apply theme text color for textLabel
    cell.textLabel.themeMap = @{kThemeMapKeyColorName : @"left_tabbar_cell_title"};
    // Apply theme image for imageView
    cell.imageView.themeMap = @{kThemeMapKeyImageName : imageName};
    
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        [[ThemeManager sharedInstance] switchToStyleByID:THEME_STYLE_CLASSIC];
    }
    else {
        [[ThemeManager sharedInstance] switchToStyleByID:THEME_STYLE_NIGHT];
    }
}

@end