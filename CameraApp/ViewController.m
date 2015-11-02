//
//  ViewController.m
//  CameraApp
//  this is a sample app for camera
//  Created by GuoRui on 10/30/15.
//  Copyright © 2015 GuoRui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
//these two delegates are needed
- (IBAction)click_bt_camera:(id)sender;
- (IBAction)click_bt_OpenPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click_bt_camera:(id)sender {
    UIImagePickerController *picController=[UIImagePickerController new];
    //have to delegate the access to viewController
    picController.delegate=self;
    picController.allowsEditing=YES;
    picController.sourceType=UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:picController animated:YES completion:nil];
    
    //delegate method for saving photo
    
    //and add to imageview
    
}

- (IBAction)click_bt_OpenPhoto:(id)sender {
    UIImagePickerController *picController=[UIImagePickerController new];
    //have to delegate the access to viewController
    picController.delegate=self;
    picController.allowsEditing=YES;
    picController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picController animated:nil completion:nil];

    
}
 //delegate method for saving photo
//after click use photo button in phone
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *photoTaken =info[UIImagePickerControllerEditedImage];//info is a dictionary and UIimage.... is key
    self.imageView_1.image=photoTaken;
    
    //save to abulm
    UIImageWriteToSavedPhotosAlbum(photoTaken, nil, nil, nil);
    
    //dismiss picker
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
