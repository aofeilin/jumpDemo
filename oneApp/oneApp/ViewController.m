//
//  ViewController.m
//  oneApp
//
//  Created by aofeilin on 2018/11/26.
//  Copyright © 2018年 com.aofeilin.com. All rights reserved.
//

#import "ViewController.h"
#import "PayApi.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpApp:(id)sender {
    if ([PayApi isOlePayAppInstalled] == YES) {
        BaseReq * baseReq = [[BaseReq alloc] init];
        [PayApi sendReq:baseReq];
    }
    else{
        NSLog(@"%@",@"不可以跳转");
    }
}

@end
