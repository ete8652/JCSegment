//
//  ViewController.m
//  JCSegmentProject
//
//  Created by Jin on 2017/6/25.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import "ViewController.h"
#import "JCSegmentView.h"

@interface ViewController ()<JCSegmentViewDelegate>
@property (strong, nonatomic) JCSegmentView *segmentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSArray *titleDatas = @[@"全部",@"未结",@"已结"];
    _segmentView = [[JCSegmentView alloc] initWithOriginY:0 Titles:titleDatas delegate:self];
    [self.view addSubview:_segmentView];
    _segmentView.delegate = self;
    _segmentView.frame = CGRectMake(0, 240, self.view.bounds.size.width, 40);
    
    //2秒后切换index
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.segmentView changeSegmentedControlWithIndex:2];
    });
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - JCSegmentView代理方法
-(void)segmentSelectIndex:(NSInteger)index{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
