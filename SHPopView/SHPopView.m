//
//  SHPopView.m
//  Exmpale
//
//  Created by CCSH on 2021/3/3.
//

#import "SHPopView.h"

#define kSHPopViewAnimation @"kSHPopViewAnimation"
#define kSHAngle(R) ((R) / 180.0 * M_PI)

@interface SHPopView () <UIGestureRecognizerDelegate>

@end

@implementation SHPopView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //蒙板颜色
        self.maskColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        //动画时间
        self.duration = 0.25;
        //初始速度
        self.initialVelocity = 0;
        //阻尼
        self.damping = 10;
        //刚度
        self.stiffness = 1000;
        //质量
        self.mass = 1;
    }
    return self;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark - 私有方法
- (void)setContentView:(UIView *)contentView {
    [_contentView.layer removeAnimationForKey:kSHPopViewAnimation];
    [_contentView removeFromSuperview];
    _contentView = contentView;
    [self addSubview:contentView];
}

#pragma mark 获取动画
- (CABasicAnimation *)getAnimation {
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    //动画执行周期
    animation.duration = self.duration;
    //开始时间
    animation.beginTime = 0;
    //保持动画结束之后的状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;

    return animation;
}

#pragma mark 获取弹簧动画
- (CASpringAnimation *)getSpringAnimation{
    CASpringAnimation *animation = [[CASpringAnimation alloc] init];
    //开始时间
    animation.beginTime = 0;
    
    //初始速度
    animation.initialVelocity = self.initialVelocity;
    //阻尼
    animation.damping = self.damping;
    //弹性
    animation.stiffness = self.stiffness;
    //质量
    animation.mass = self.mass;

    //动画执行周期(弹簧可以用 animation.settlingDuration 比较准确，为了封装就用 duration 了)
    animation.duration = (self.duration >= 0) ? self.duration : animation.settlingDuration;
    //恢复之前
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeRemoved;

    return animation;
}

#pragma mark 移除
- (void)remove {
    [self removeFromSuperview];
}

#pragma mark - 动画
#pragma mark 显示动画
- (void)showAnimationFade:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"opacity";
    //动画执行周期
    animation.duration = self.duration;
    //进行改变
    animation.fromValue = @0;

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)showAnimationScale:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"transform.scale";
    //进行改变
    animation.fromValue = @0;
    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)showAnimationTop:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"position.y";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //进行改变
    animation.fromValue = @(-CGRectGetHeight(view.frame)/2);

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)showAnimationBottom:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"position.y";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //进行改变
    animation.fromValue = @(CGRectGetHeight(self.frame) + CGRectGetHeight(view.frame)/2);

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)showAnimationLeft:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"position.x";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //进行改变
    animation.fromValue = @(-CGRectGetWidth(view.frame)/2);

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)showAnimationRight:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"position.x";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //进行改变
    animation.fromValue = @(CGRectGetWidth(self.frame) + CGRectGetWidth(view.frame)/2);

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)showAnimationSpringTop:(UIView *)view{
    CASpringAnimation *animation = [self getSpringAnimation];
    animation.keyPath = @"position.y";
    //进行改变
    animation.fromValue = @(-CGRectGetHeight(view.frame)/2);
    
    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)showAnimationSpringBottom:(UIView *)view{
    CASpringAnimation *animation = [self getSpringAnimation];
    animation.keyPath = @"position.y";
    //进行改变
    animation.fromValue = @(CGRectGetHeight(self.frame) + CGRectGetHeight(view.frame)/2);
    
    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)showAnimationSpringLeft:(UIView *)view{
    CASpringAnimation *animation = [self getSpringAnimation];
    animation.keyPath = @"position.x";
    //进行改变
    animation.fromValue = @(-CGRectGetWidth(view.frame)/2);
    
    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)showAnimationSpringRight:(UIView *)view{
    CASpringAnimation *animation = [self getSpringAnimation];
    animation.keyPath = @"position.x";
    
    //进行改变
    animation.fromValue = @(CGRectGetWidth(self.frame) + CGRectGetWidth(view.frame)/2);
    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

#pragma mark 消失动画
- (void)hideAnimationFade:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"opacity";
    //动画执行周期
    animation.duration = self.duration;
    //进行改变
    animation.toValue = @0;

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)hideAnimationScale:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"transform.scale";
    //进行改变
    animation.toValue = @0;

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)hideAnimationTop:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"position.y";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //进行改变
    animation.toValue = @(-CGRectGetHeight(view.frame)/2);

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)hideAnimationBottom:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"position.y";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //进行改变
    animation.toValue = @(CGRectGetHeight(self.frame) + CGRectGetHeight(view.frame)/2);

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)hideAnimationLeft:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"position.x";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //进行改变
    animation.toValue = @(-CGRectGetWidth(view.frame)/2);

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

- (void)hideAnimationRight:(UIView *)view {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = @"position.x";
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //进行改变
    animation.toValue = @(CGRectGetWidth(self.frame) + CGRectGetWidth(view.frame)/2);

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

#pragma mark 公共动画
#pragma mark 旋转
- (void)animationRotation:(UIView *)view direction:(NSString *)direction {
    CABasicAnimation *animation = [self getAnimation];
    //动画效果
    animation.keyPath = [NSString stringWithFormat:@"transform.rotation.%@", direction];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //进行改变
    animation.fromValue = @(2 * M_PI);

    //恢复之前
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeRemoved;

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

#pragma mark 抖动
- (void)animationJitter:(UIView *)view {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];

    //动画效果
    animation.keyPath = @"transform.rotation";
    //进行改变
    animation.values = @[ @(kSHAngle(-5)), @(kSHAngle(5)), @(kSHAngle(-5)) ];
    //次数
    animation.repeatCount = 2;
    //时间
    animation.duration = 0.1;
    //恢复之前
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeRemoved;

    //视图添加动画
    [view.layer addAnimation:animation forKey:kSHPopViewAnimation];
}

#pragma mark - 公开方法
#pragma mark 显示
- (void)show {
    [self showInView:nil];
}

- (void)showInView:(UIView *)view {
    if (!view) {
        view = [[[UIApplication sharedApplication] windows] firstObject];
    }

    NSAssert(self.contentView != nil, @"contentView 不能为空！");
    self.backgroundColor = self.maskColor;
    self.frame = view.bounds;
    [view addSubview:self];

    if (self.isClickDisappear) {
        //点击消失
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    _isShowing = YES;
    //移除之前动画
    [self.contentView.layer removeAnimationForKey:kSHPopViewAnimation];
    
    //动画
    switch (self.showAnimation) {
        case SHPopViewAnimation_none: {
        } break;
        case SHPopViewAnimation_scale: {
            [self showAnimationScale:self.contentView];
        } break;
        case SHPopViewAnimation_top: {
            [self showAnimationTop:self.contentView];
        } break;
        case SHPopViewAnimation_bottom: {
            [self showAnimationBottom:self.contentView];
        } break;
        case SHPopViewAnimation_left: {
            [self showAnimationLeft:self.contentView];
        } break;
        case SHPopViewAnimation_right: {
            [self showAnimationRight:self.contentView];
        } break;
        case SHPopViewAnimation_rotationX: {
            [self animationRotation:self.contentView direction:@"x"];
        } break;
        case SHPopViewAnimation_rotationY: {
            [self animationRotation:self.contentView direction:@"y"];
        } break;
        case SHPopViewAnimation_rotationZ: {
            [self animationRotation:self.contentView direction:@"z"];
        } break;
        case SHPopViewAnimation_spring_top: {
            [self showAnimationSpringTop:self.contentView];
        } break;
        case SHPopViewAnimation_spring_bottom: {
            [self showAnimationSpringBottom:self.contentView];
        } break;
        case SHPopViewAnimation_spring_left: {
            [self showAnimationSpringLeft:self.contentView];
        } break;
        case SHPopViewAnimation_spring_right: {
            [self showAnimationSpringRight:self.contentView];
        } break;
        default: {
            [self showAnimationFade:self.contentView];
        } break;
    }

    if (self.isJitter) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self animationJitter:self.contentView];
        });
    }
}

#pragma mark 隐藏
- (void)hide {
    if (!self.isShowing) {
        return;
    }
    _isShowing = NO;
    [self.contentView.layer removeAnimationForKey:kSHPopViewAnimation];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self remove];
    });

    //动画
    switch (self.hideAnimation) {
        case SHPopViewAnimation_none: {
        } break;
        case SHPopViewAnimation_scale: {
            [self hideAnimationScale:self.contentView];
        } break;
        case SHPopViewAnimation_top: {
            [self hideAnimationTop:self.contentView];
        } break;
        case SHPopViewAnimation_bottom: {
            [self hideAnimationBottom:self.contentView];
        } break;
        case SHPopViewAnimation_left: {
            [self hideAnimationLeft:self.contentView];
        } break;
        case SHPopViewAnimation_right: {
            [self hideAnimationRight:self.contentView];
        } break;
        case SHPopViewAnimation_rotationX: {
            [self animationRotation:self.contentView direction:@"x"];
        } break;
        case SHPopViewAnimation_rotationY: {
            [self animationRotation:self.contentView direction:@"y"];
        } break;
        case SHPopViewAnimation_rotationZ: {
            [self animationRotation:self.contentView direction:@"z"];
        } break;
        default: {
            [self hideAnimationFade:self.contentView];
        } break;
    }
}

@end
