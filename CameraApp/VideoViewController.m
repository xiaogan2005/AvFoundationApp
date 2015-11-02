//
//  VideoViewController.m
//  CameraApp
//
//  Created by GuoRui on 10/30/15.
//  Copyright © 2015 GuoRui. All rights reserved.
//
// this file is undone
#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>
//for having a media player
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>

@interface VideoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)startVideo:(id)sender;
- (IBAction)playVideo:(id)sender;

@property(nonatomic,strong)AVPlayerViewController *videoController;
@property(nonatomic,strong)NSURL *videoUrl;
//@property avplayer;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startVideo:(id)sender {
    UIImagePickerController *pc=[UIImagePickerController new];
    pc.delegate=self;
    pc.allowsEditing=YES;
    
    
    
    //what is kUTType???
    pc.sourceType=UIImagePickerControllerSourceTypeCamera;
    pc.mediaTypes=[[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
    [self presentViewController:pc animated:YES completion:nil];
}

- (IBAction)playVideo:(id)sender {
    self.videoController = [[AVPlayerViewController alloc]init];
    AVPlayerItem *videoItem =[[AVPlayerItem alloc]initWithURL:self.videoUrl];
    
    self.videoController.player = [AVPlayer playerWithPlayerItem:videoItem];
    [self.videoController.player play];
    
    [self presentViewController:self.videoController animated:YES completion:nil];

    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.videoUrl=info[UIImagePickerControllerMediaURL];
    
    //dismiss
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
