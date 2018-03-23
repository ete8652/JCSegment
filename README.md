
## Preview
![image](https://github.com/ete8652/JCSegment/blob/master/GIF/slide.gif)

## Usage
need add "JCSegmentView.h" and <JCSegmentViewDelegate> to u project.
```objc
  
    NSArray *titleDatas = @[@"全部",@"未结",@"已结"];
    _segmentView = [[JCSegmentView alloc] initWithOriginY:0 Titles:titleDatas delegate:self];
    [self.view addSubview:_segmentView];
    _segmentView.delegate = self;
    _segmentView.frame = CGRectMake(0, 240, self.view.bounds.size.width, 40);
```

