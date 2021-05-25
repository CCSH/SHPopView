//
//  ViewController.m
//  Exmpale
//
//  Created by CCSH on 2021/3/3.
//

#import "ViewController.h"
#import "SHPopView.h"

@interface ViewController ()

@property (nonatomic, strong) SHPopView *popView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(100, 100, 100, 150);
    lab.backgroundColor = [UIColor redColor];
    lab.text = @"啦啦啦啦";
    lab.textAlignment = NSTextAlignmentCenter;
    
    self.popView = [[SHPopView alloc] init];
    self.popView.contentView = lab;
    self.popView.showAnimation = SHPopViewAnimation_top;
    self.popView.hideAnimation = SHPopViewAnimation_bottom;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.popView show];
}

@end
