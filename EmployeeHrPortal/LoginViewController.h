//
//  LoginViewController.h
//  EmployeePortal
//
//  Created by GMSIndia1 on 7/16/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobsiteViewController.h"
#import "NewMedicalViewController.h"
#import "RaceViewController.h"
#import "EmployeeViewController.h"
#import "CourseDrugViewController.h"
#import "UploadImageViewController.h"
#import "UploadDocViewController.h"
#import "Validation.h"
#import "DocumentsViewController.h"
#import "ShowDocViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    BOOL recordResults;
 NSInteger Applicantid;
    NSString *ssnstring;
}
/*Outlets */
- (IBAction)logoutbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationBar *navbar;
@property(strong,nonatomic)Validation *val;
@property (strong, nonatomic) NSString *connectstring;
@property (strong, nonatomic) IBOutlet UITextField *ssntxtfld;
@property (strong, nonatomic) IBOutlet UITextField *passwordtxtfld;
@property (strong, nonatomic)UITabBarController*tabbarcntrl;
@property(strong,nonatomic)JobsiteViewController*firstVCtrl;
/*Xmlparser*/
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSMutableData *webData;

- (IBAction)loginbtn:(id)sender;
- (IBAction)cancelbtn:(id)sender;


/*iphone Outlets*/
@property (strong, nonatomic) IBOutlet UITextField *SSNtxtfld_iphone;
@property (strong, nonatomic) IBOutlet UITextField *passwordtxtfld_iphone;

- (IBAction)loginbtn_iphone:(id)sender;
-(IBAction)textfldshouldreturn:(id)sender;
-(void)processLogout:(NSNotification *)aNotification;

- (IBAction)cancelbtn_iphone:(id)sender;
- (IBAction)homebtn:(id)sender;

@end
