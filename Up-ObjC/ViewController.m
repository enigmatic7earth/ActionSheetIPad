//
//  ViewController.m
//  Up-ObjC
//
//  Created by NETBIZ on 03/09/18.
//  Copyright © 2018 Netbiz.in. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusAuthorized:
                NSLog(@"PHAuthorizationStatusAuthorized");
                break;
            case PHAuthorizationStatusDenied:
                NSLog(@"PHAuthorizationStatusDenied");
                break;
            case PHAuthorizationStatusNotDetermined:
                NSLog(@"PHAuthorizationStatusNotDetermined");
                break;
            case PHAuthorizationStatusRestricted:
                NSLog(@"PHAuthorizationStatusRestricted");
                break;
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showActionSheet:(id)sender {
    UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Pick a file" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Camera");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // Set source to the camera
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        // Delegate is self
        imagePicker.delegate = self;
        // Allow editing of image ?
        // Show image picker
        [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction * gallery = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Gallery");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        // Set source to the camera
        imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        // Delegate is self
        imagePicker.delegate = self;
        // Allow editing of image ?
        // Show image picker
        [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction * document = [UIAlertAction actionWithTitle:@"Choose a document" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Document");
        NSArray *types = @[(NSString*)kUTTypeImage,(NSString*)kUTTypeSpreadsheet,(NSString*)kUTTypePresentation,(NSString*)kUTTypeDatabase,(NSString*)kUTTypeFolder,(NSString*)kUTTypeZipArchive,(NSString*)kUTTypeVideo,(NSString*)kUTTypePDF];
        //Create a object of document picker view and set the mode to Import
        UIDocumentPickerViewController *docPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:types inMode:UIDocumentPickerModeImport];
        //Set the delegate
        docPicker.delegate = self;
        //present the document picker
        [self presentViewController:docPicker animated:YES completion:nil];
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancelled");
    }];
    
    
    [actionSheet addAction:camera];
    [actionSheet addAction:gallery];
    [actionSheet addAction:document];
    [actionSheet addAction:cancel];
    
    //For iPad a PopOverViewController is needed
//    UIPopoverPresentationController * popoverController = [[UIPopoverPresentationController alloc] initWithPresentedViewController:actionSheet presentingViewController:self];
    UIPopoverPresentationController * popoverController = actionSheet.popoverPresentationController;
    actionSheet.modalPresentationStyle = UIModalPresentationPopover;
    
    popoverController.sourceView = self.view;
    
    popoverController.sourceRect =  CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 0, 0); //CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
    popoverController.permittedArrowDirections = 0; //UIPopoverArrowDirectionUnknown;
    popoverController.delegate = self;
    
    [self presentViewController:actionSheet animated:true completion:nil];

}
-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    return YES;
}


@end
