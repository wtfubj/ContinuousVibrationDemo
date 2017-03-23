//
//  ViewController.m
//  ContinuousVibration
//
//  Created by 付卫涛 on 2017/3/23.
//  Copyright © 2017年 付卫涛. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
{
    SystemSoundID sound;
}
//振动计时器
@property (nonatomic,strong)NSTimer *_vibrationTimer;
@end

@implementation ViewController
@synthesize _vibrationTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
//开始响铃及振动
-(IBAction)startShakeSound:(id)sender{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"2125" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &sound);
    AudioServicesAddSystemSoundCompletion(sound, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(sound);
    
    
    /**
     初始化计时器  每一秒振动一次

     @param playkSystemSound 振动方法
     @return
     */
    _vibrationTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playkSystemSound) userInfo:nil repeats:YES];
}
//振动
- (void)playkSystemSound{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
//停止响铃及振动
-(IBAction)stopShakeSound:(id)sender{
    
    [_vibrationTimer invalidate];
    AudioServicesRemoveSystemSoundCompletion(sound);
    AudioServicesDisposeSystemSoundID(sound);
    
}
//响铃回调方法
void soundCompleteCallback(SystemSoundID sound,void * clientData) {
    AudioServicesPlaySystemSound(sound);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
