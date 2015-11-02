//
//  AudioRecordViewController.m
//  CameraApp
//
//  Created by GuoRui on 10/30/15.
//  Copyright © 2015 GuoRui. All rights reserved.
//

#import "AudioRecordViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioRecordViewController ()<AVAudioPlayerDelegate,AVAudioRecorderDelegate>
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)play:(id)sender;


@end
AVAudioPlayer *player;
AVAudioRecorder *recorder;
NSURL * audioUrl;
@implementation AudioRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initPlayerAndRecorder];
    [self createAVAudioSession];
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

-(void)initPlayerAndRecorder{
    NSArray *path=[[NSArray alloc]initWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject],@"myAudioFile.m4a", nil];
    
   audioUrl=[NSURL fileURLWithPathComponents:path];
    NSLog(@"the audio path is %@",audioUrl);
    
}

-(void)createAVAudioSession{
    //singleton here, for create session
    AVAudioSession *recordSession=[AVAudioSession sharedInstance];
    [recordSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    
    //record setting using a dict to save
    NSMutableDictionary *recordSetting=[[NSMutableDictionary alloc]init];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.00] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
    //set recorder for prepare to record
    recorder=[[AVAudioRecorder alloc]initWithURL:audioUrl settings:recordSetting error:nil];
    
    recorder.delegate=self;
    recorder.meteringEnabled=YES;
    [recorder prepareToRecord];
    
}

- (IBAction)start:(id)sender {
    if(player.playing){
        [player stop];
    }
    if(!recorder.recording){
        AVAudioSession *recordSession=[AVAudioSession sharedInstance];
        //start session
        [recordSession setActive:YES error:nil];
        [recorder record];
        NSLog(@"recorder starts");
        
    }else{
        //the recorder is recording
        [recorder pause];
        NSLog(@"recorder pause in start");
    }
}

- (IBAction)stop:(id)sender {
    [recorder stop];
    AVAudioSession *recordSession=[AVAudioSession sharedInstance];
    //stop session
    [recordSession setActive:NO error:nil];
    NSLog(@"recorder stop");

}

- (IBAction)play:(id)sender {
    
    if(!recorder.recording){
        player =[[AVAudioPlayer alloc]initWithContentsOfURL: audioUrl error:nil];
        player.delegate=self;
        [player play];
    }
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"done with playing audio file");
    

}
@end
