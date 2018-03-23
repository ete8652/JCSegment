//
//  JCSegmentedView.m
//  CustomSegControlView
//
//  Created by Jin on 17-6-12.
//  Copyright (c) 2017年 Jin. All rights reserved.
//

#import "JCSegmentView.h"

#define JC_Height 40.0
#define JC_Width ([UIScreen mainScreen].bounds.size.width)
#define Min_Width_4_Button 50.0
#define JCRGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define Define_Tag_add 1000

#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface JCSegmentView()

@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)NSMutableArray *array4Btn;
@property (strong, nonatomic)UIView *slideLineView;

@end

@implementation JCSegmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles delegate:(id)delegate
{
    CGRect rect4View = CGRectMake(.0f, y, JC_Width, JC_Height);
    if (self = [super initWithFrame:rect4View]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setUserInteractionEnabled:YES];
        
        self.delegate = delegate;
        
        //
        //  array4btn
        //
        _array4Btn = [[NSMutableArray alloc] initWithCapacity:[titles count]];
        
        //
        //  set button
        //
        CGFloat width4btn = rect4View.size.width/[titles count];
        if (width4btn < Min_Width_4_Button) {
            width4btn = Min_Width_4_Button;
        }
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.contentSize = CGSizeMake([titles count]*width4btn, JC_Height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i<[titles count]; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*width4btn, .0f, width4btn, JC_Height);
            [btn setTitleColor:UIColorFromRGBValue(0x454545) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:JCRGBCOLOR(223, 63, 84) forState:UIControlStateSelected];
            [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = Define_Tag_add+i;
            [_scrollView addSubview:btn];
            [_array4Btn addObject:btn];
            
            if (i == 0) {
                btn.selected = YES;
            }
        }
        
        
        //
        // Top lineView
        //
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JC_Width, 1)];
        topLineView.backgroundColor = JCRGBCOLOR(233, 233, 233);
        [_scrollView addSubview:topLineView];
        //
        //  bottom lineView
        //
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, JC_Height-1, JC_Width, 1)];
        bottomLineView.backgroundColor = JCRGBCOLOR(233, 233, 233);
        [_scrollView addSubview:bottomLineView];
        
        //
        //  bottom lineView
        //
        _slideLineView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, JC_Height-2, width4btn-10.0f, 2.0f)];
        _slideLineView.backgroundColor = JCRGBCOLOR(223, 63, 84);
        [_scrollView addSubview:_slideLineView];
        
        [self addSubview:_scrollView];
    }
    return self;
}

//
//  btn clicked
//
- (void)segmentedControlChange:(UIButton *)btn
{
    
    btn.selected = YES;
    for (UIButton *subBtn in self.array4Btn) {
        if (subBtn != btn) {
            subBtn.selected = NO;
        }
    }
    
    CGRect rect4boottomLine = self.slideLineView.frame;
    rect4boottomLine.origin.x = btn.frame.origin.x +5;
    
    CGPoint pt = CGPointZero;
    BOOL canScrolle = NO;
    if ((btn.tag - Define_Tag_add) >= 2 && [_array4Btn count] > 4 && [_array4Btn count] > (btn.tag - Define_Tag_add + 2)) {
        pt.x = btn.frame.origin.x - Min_Width_4_Button*1.5f;
        canScrolle = YES;
    }else if ([_array4Btn count] > 4 && (btn.tag - Define_Tag_add + 2) >= [_array4Btn count]){
        pt.x = (_array4Btn.count - 4) * Min_Width_4_Button;
        canScrolle = YES;
    }else if (_array4Btn.count > 4 && (btn.tag - Define_Tag_add) < 2){
        pt.x = 0;
        canScrolle = YES;
    }
    
    if (canScrolle) {
        [UIView animateWithDuration:0.3 animations:^{
            //_scrollView.contentOffset = pt;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.slideLineView.frame = rect4boottomLine;
            }];
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.slideLineView.frame = rect4boottomLine;
        }];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentSelectIndex:)]) {
        [self.delegate segmentSelectIndex:btn.tag - 1000];
    }
}

// delegete method
- (void)changeSegmentedControlWithIndex:(NSInteger)index
{
    if (index > [_array4Btn count]-1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"index 超出范围" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sureAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        return;
    }

    UIButton *btn = [_array4Btn objectAtIndex:index];
    [self segmentedControlChange:btn];
}


@end
