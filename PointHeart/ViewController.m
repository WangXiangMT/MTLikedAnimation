//
//  ViewController.m
//  PointHeart
//
//  Created by 王翔 on 16/7/26.
//  Copyright © 2016年 WangXiangMT. All rights reserved.
//

#import "ViewController.h"

#define kRateX 300
#define kRateY 500

@interface ViewController ()

@property (nonatomic , strong) CABasicAnimation *animation;

@property (nonatomic , strong) CAKeyframeAnimation *keyAnima;

@property (nonatomic , strong) CABasicAnimation *alphaAnimation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self likeAnimation];
}

-(void)likeAnimation
{
    int tagNumber = 500000;
    tagNumber += 1;
    
    UIImage *image = [UIImage imageNamed:[self randomImageName]];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    imageview.center = CGPointMake(-1000, -1000);
    imageview.tag = tagNumber;
    [self.view addSubview:imageview];
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = 2.0;
    group.repeatCount = 1;
    
    [group setAnimations:[NSArray arrayWithObjects:[self scaleAnimation] ,[self positionAnimatin],[self alphaAnimatin],  nil]];
    group.delegate = self;
    
    [group setValue:[NSNumber numberWithInteger:tagNumber] forKey:@"animationName"];
    [imageview.layer addAnimation:group forKey:@"wendingding"];
    

    
}

-(CABasicAnimation *)scaleAnimation
{
    _animation = [[CABasicAnimation alloc] init];
    [_animation setKeyPath:@"transform.scale"];
    _animation.duration = 0.5;
    _animation.removedOnCompletion = false;
    [_animation setFromValue:[NSNumber numberWithFloat:0.1]];
    [_animation setToValue:[NSNumber numberWithFloat:1.0]];
    return _animation;
    
    
    
}

-(CAKeyframeAnimation *)positionAnimatin
{
    _keyAnima = [[CAKeyframeAnimation alloc] init];
    //路径可不能写错
    [_keyAnima setKeyPath:@"position"];
    
    //路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, kRateX, kRateY);
    int controlX = (int)((arc4random() % (100 + 1))) - 50;
    int controlY = (int)((arc4random() % (130 + 1))) + 50;
    int entX = (int)((arc4random() % (100 + 1))) - 50;
    
    CGPathAddQuadCurveToPoint(path, nil, (CGFloat)(kRateX - controlX), (CGFloat)(kRateY - controlY), (CGFloat)(kRateX + entX), kRateY - 260);
    _keyAnima.path = path;
    _keyAnima.removedOnCompletion = false;
    _keyAnima.fillMode = kCAFillModeForwards;
    _keyAnima.duration = 2.0;
    _keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    return _keyAnima;
}

-(CABasicAnimation *)alphaAnimatin
{
    _alphaAnimation = [[CABasicAnimation alloc] init];
    [_alphaAnimation setKeyPath:@"opacity"];
    _alphaAnimation.duration = 1.5;
    _alphaAnimation.removedOnCompletion = false;
    _alphaAnimation.fromValue = [NSNumber numberWithInteger:1];
    _alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    _alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    _alphaAnimation.beginTime = 0.5;
    
    return _alphaAnimation;
}

-(NSString *)randomImageName
{
    int number = (int)(arc4random()%(4+1));
    NSString *randomImageName;
    switch (number) {
        case 1:
            randomImageName = @"bHeart";
            break;
        case 2:
            randomImageName = @"gHeart";
            break;
        case 3:
            randomImageName = @"rHeart";
            break;
        case 4:
            randomImageName = @"yHeart";
            break;
            
        default: randomImageName = @"bHeart";
            break;
    }
    return randomImageName;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
