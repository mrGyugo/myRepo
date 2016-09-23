//
//  PlayVideoController.m
//  PsychologistIOS
//
//  Created by Виктор Мишустин on 28.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "PlayVideoController.h"
#import "KrVideoPlayerController.h"
#import "LoginController.h"

@interface PlayVideoController ()

@property (nonatomic, strong) KrVideoPlayerController  *videoController;

@end

@implementation PlayVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"video2" ofType:@"mov"];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    [self playVideoWithURL:fileUrl];
    [self.videoController fullScreenHide];
    [self.videoController allHide];
    [self.videoController play];
    
    [self performSelector:@selector(pushLogin) withObject:nil afterDelay:7.f];

}

#pragma mark - Video

- (void)playVideoWithURL: (NSURL*) myURL {
    [self addVideoPlayerWithURL:myURL];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(- 220, 0, self.view.frame.size.width + 800, self.view.frame.size.height)];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        [self.view addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    
}
//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool{
    self.navigationController.navigationBar.hidden = Bool;
    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) pushLogin
{
    LoginController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
    [self.navigationController pushViewController:detail animated:YES];
    [self performSelector:@selector(stopVideo) withObject:nil afterDelay:3];
}

- (void) stopVideo
{
    [self.videoController stop];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
