//
//  BasicdetailsViewController.m
//  EmployeePortal
//
//  Created by GMSIndia1 on 7/8/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "BasicdetailsViewController.h"
#import "Base64.h"
@interface BasicdetailsViewController ()

@end

@implementation BasicdetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title=NSLocalizedString(@"Personal Details", @"Personal Details");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    detailbtnclicked_iphone=0;
[self getstates];
    _suffixarray=[[NSMutableArray alloc]initWithObjects:@"None",@"JR.",@"SR.",@"II",@"III" ,nil];
    _suffixarray_iphone=[[NSMutableArray alloc]initWithObjects:@"None",@"JR.",@"SR.",@"II",@"III" ,nil];
    _scrollview.frame=CGRectMake(0, 0,1024, 768);
    [ _scrollview setContentSize:CGSizeMake(1024,850)];
    _scroll_iphone.frame=CGRectMake(0, 0, 500,640);
    [_scroll_iphone setContentSize:CGSizeMake(500,1500)];

    _imgvw.userInteractionEnabled = YES;
    UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handlePinch:)];
    pgr.delegate = (id)self;
    [_imgvw addGestureRecognizer:pgr];
    // Do any additional setup after loading the view from its nib.
  
//self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:0.2 green:0.5 blue:0.5 alpha:1];
    self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
       //self.navigationController.navigationBar.tintColor=[UIColor cyanColor];
    
    
    UIBarButtonItem *homebutton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"rounded"] style:UIBarButtonItemStylePlain target:self action:@selector(homeAction)];
    [self.navigationItem setRightBarButtonItem:homebutton animated:YES];
      self.navigationItem.hidesBackButton=YES;
}
//-(void)homeAction{
//   [self UpdateApplicantData];
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}
-(void)homeAction
{ [self UpdateApplicantData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"home" object:self userInfo:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self GetApplicantDetails];
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self UpdateApplicantData];
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Action

- (IBAction)suffixbtn:(id)sender {
    popovertype=1;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 60, 250)];
    //200,250
    popoverView.backgroundColor = [UIColor lightTextColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 60, 250)];
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
    _popOverTableView.separatorColor=[UIColor cyanColor];
    
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(60, 250);
    
    //create a popover controller
    self.popOverController1 = [[UIPopoverController alloc]
                               initWithContentViewController:popoverContent];
    [self.popOverController1 presentPopoverFromRect:_sufixbtnlbl.frame
                                             inView:self.scrollview
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];

    
}

- (IBAction)statebtn:(id)sender
{    popovertype=2;
    [self createPopover];
    [self getstates];
}

- (IBAction)countrybtn:(id)sender {
}

- (IBAction)dobbtn:(id)sender {
    [self createCalenderPopover];
}

- (IBAction)gendersegmentcntrl:(id)sender {
}

- (IBAction)continuebtn:(id)sender {
    
    [self UpdateApplicantData];
    
    
    
}

- (IBAction)cancelbtn:(id)sender {
}

#pragma mark - Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_popOverTableView) {
        switch (popovertype) {
            case 1:
                return [_suffixarray count];
                break;
            case 2:
                return [_stateArray count];
                break;
            default:
                break;
        }

        
    }
    
    
       
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
     
    }


    if (tableView==_popOverTableView) {
               
        switch (popovertype) {
            case 1:
                cell.textLabel.text=[_suffixarray objectAtIndex:indexPath.row];
                break;
            case 2:
                cell.textLabel.text=[_stateArray objectAtIndex:indexPath.row];
                break;
            default:
                break;
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_popOverTableView) {
        
        
        
        switch (popovertype) {
            case 1:
                
                [_sufixbtnlbl setTitle:[_suffixarray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                
                
                break;
            case 2:
                
                [_statebtnlbl setTitle:[_stateArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                
                
                
                break;
            default:
                break;
        }
}


}

#pragma mark - Webservice


-(void)GetApplicantDetails{
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<GetApplicantDetails xmlns=\"http://webserv.kontract360.com/\">\n"
                    "<AppId>%d</AppId>\n"
                    "</GetApplicantDetails>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://webserv.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://webserv.kontract360.com/GetApplicantDetails" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
    
}


-(void)UpdateApplicantData{
    recordResults = FALSE;
    NSString *soapMessage;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
    NSLog(@"date%@",_dobbtnlbl.titleLabel.text);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"MM-dd-yyyy"];
    
    NSDate *dateString = [dateFormat dateFromString:_dobbtnlbl.titleLabel.text];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString* sqldate=[dateFormat1 stringFromDate:dateString];
    
   

    
    if(_gendersegmentcntrl.selectedSegmentIndex==0)
    {
        genderstg=1;
    }
    else if(_gendersegmentcntrl.selectedSegmentIndex==1)
    {
        genderstg=0;
    }
       

    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UpdateApplicantData xmlns=\"http://webserv.kontract360.com/\">\n"
                   "<ApplicantId>%d</ApplicantId>\n"
                   "<NameSuffix>%@</NameSuffix>\n"
                   "<FirstName>%@</FirstName>\n"
                   "<LastName>%@</LastName>\n"
                   "<Address>%@</Address>\n"
                   "<City>%@</City>\n"
                   "<State>%@</State>\n"
                   "<Zip>%@</Zip>\n"
                   "<SSN>%@</SSN>\n"
                   "<DOB>%@</DOB>\n"
                   "<Country>%@</Country>\n"
                   "<Gender>%d</Gender>\n"
                   "<Email>%@</Email>\n"
                   "<CellphoneNo>%@</CellphoneNo>\n"
                   "<PhoneNo>%@</PhoneNo>\n"
                   "<AlternateNo>%@</AlternateNo>\n"
                   "<EmergencyContactName>%@</EmergencyContactName>\n"
                   "<EmergencyContactNo>%@</EmergencyContactNo>\n"
                   "<DrivingLicenseNo>%@</DrivingLicenseNo>\n"
                   "<LicenseIssuingState>%@</LicenseIssuingState>\n"
                   "<NameInLicense>%@</NameInLicense>\n"
                   "</UpdateApplicantData>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,_sufixbtnlbl.titleLabel.text,_firstnametxtfld.text,_lastnametxtfld.text,_Addresstxtfld.text,_citytxtfld.text,_statebtnlbl.titleLabel.text,_ziptextflield.text,_ssntxtfld.text,sqldate,_countrybtnlbl.titleLabel.text,genderstg,_emailtxtfld.text,_mobiletxtfld.text,_homenumbertxtfld.text,_alternativenumtxtfld.text,_emergencytxtfld.text,_contactnumbtxtfld.text,_driverlicencetxtfld.text,_stateissuetxtfld.text,_nameinlicencetxtfld.text];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://webserv.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://webserv.kontract360.com/UpdateApplicantData" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
     }
    
     else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
     {
         if(_gendersegment_iphone.selectedSegmentIndex==0)
         {
             genderstg=1;
         }
         else if(_gendersegment_iphone.selectedSegmentIndex==1)
         {
             genderstg=0;
         }
//         NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//         [dateFormat setDateFormat: @"MM-dd-yyyy"];
//         
//         NSDate *dateString = [dateFormat dateFromString:_dobtext_iphone.text];
//         NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
//         [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
//         NSString* sqldate=[dateFormat1 stringFromDate:dateString];
         
         soapMessage = [NSString stringWithFormat:
                        
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                        "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                        
                        
                        "<soap:Body>\n"
                        
                        "<UpdateApplicantData xmlns=\"http://webserv.kontract360.com/\">\n"
                        "<ApplicantId>%d</ApplicantId>\n"
                        "<NameSuffix>%@</NameSuffix>\n"
                        "<FirstName>%@</FirstName>\n"
                        "<LastName>%@</LastName>\n"
                        "<Address>%@</Address>\n"
                        "<City>%@</City>\n"
                        "<State>%@</State>\n"
                        "<Zip>%@</Zip>\n"
                        "<SSN>%@</SSN>\n"
                        "<DOB>%@</DOB>\n"
                        "<Country>%@</Country>\n"
                        "<Gender>%d</Gender>\n"
                        "<Email>%@</Email>\n"
                        "<CellphoneNo>%@</CellphoneNo>\n"
                        "<PhoneNo>%@</PhoneNo>\n"
                        "<AlternateNo>%@</AlternateNo>\n"
                        "<EmergencyContactName>%@</EmergencyContactName>\n"
                        "<EmergencyContactNo>%@</EmergencyContactNo>\n"
                        "<DrivingLicenseNo>%@</DrivingLicenseNo>\n"
                        "<LicenseIssuingState>%@</LicenseIssuingState>\n"
                        "<NameInLicense>%@</NameInLicense>\n"
                        "</UpdateApplicantData>\n"
                        "</soap:Body>\n"
                        "</soap:Envelope>\n",_Applicantid,_suffixbtn_iphone.titleLabel.text,_firstnametxt_iphone.text,_lastnametxt_iphone.text,_homeaddresstxt_iphone.text,_citytxt_iphone.text,_statebtn_iphone.titleLabel.text,_ziptxt_iphone.text,_ssntextfield_iphone.text,_dobtext_iphone.text,_countrytxt_iphone.titleLabel.text,genderstg,_emailtxt_iphone.text,_mobilenotext_iphone.text,_homenotxt_iphone.text,_alternatenotxt_iphone.text,_emergencycontactnametxt_iphone.text,_contactnotxt_iphone.text,_drivinglicenceno_iphone.text,_stateissuetxt_iphone.text,_nameonlicenct_iphone.text];
         NSLog(@"soapmsg%@",soapMessage);
         
         
         // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
         NSURL *url = [NSURL URLWithString:@"http://webserv.kontract360.com/service.asmx"];
         
         NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
         
         NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
         
         [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
         
         [theRequest addValue: @"http://webserv.kontract360.com/UpdateApplicantData" forHTTPHeaderField:@"Soapaction"];
         
         [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
         [theRequest setHTTPMethod:@"POST"];
         [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
         
         
         NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
         
         if( theConnection )
         {
             _webData = [NSMutableData data];
         }
         else
         {
             ////NSLog(@"theConnection is NULL");
         }

     }
    
}
-(void)getstates
{
    popovertype=2;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   "<soap:Body>\n"
                   "<SelectState xmlns=\"http://webserv.kontract360.com/\">\n"
                   "</SelectState>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://webserv.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://webserv.kontract360.com/SelectState" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    

}

#pragma mark - Connection
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[_webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   	[_webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *  Alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"ERROR with theConenction" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [Alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %d", [_webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [_webData mutableBytes] length:[_webData length] encoding:NSUTF8StringEncoding];
	NSLog(@"xml===== %@",theXML);
	
	
	if( _xmlParser )
	{
		
	}
	
	_xmlParser = [[NSXMLParser alloc] initWithData: _webData];
	[_xmlParser setDelegate:(id)self];
	[_xmlParser setShouldResolveExternalEntities: YES];
	[_xmlParser parse];
    [_popOverTableView reloadData];
    
        
     
}


#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    
    
    if([elementName isEqualToString:@"GetApplicantDetailsResult"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"NameSuffix"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"FirstName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"LastName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"appAddress"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"LastName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"appAddress"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"City"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"StateName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Zip"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"StateName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"SSN"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    

    if([elementName isEqualToString:@"DOB"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
       
    
    if([elementName isEqualToString:@"CountryName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"Gender"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"Email"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"CellphoneNo"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"PhoneNo"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"AlternateNo"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"EmergencyContactName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"DrivingLicenseNo"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }


    
    if([elementName isEqualToString:@"LicenseIssuingState"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"NameInLicense"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"SelectStateResult"])
    {
        _stateArray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

   
    if([elementName isEqualToString:@"state_id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;

    }
    if([elementName isEqualToString:@"state_name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }

    
    if([elementName isEqualToString:@"state_abbr"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"EmergencyContactNo"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }

    if([elementName isEqualToString:@"UploadImageResult"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"url"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

  
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    
	if( recordResults )
        
	{
        
        
		[_soapResults appendString: string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"NameSuffix"])
    {
        recordResults = FALSE;
        [_sufixbtnlbl setTitle:_soapResults forState:UIControlStateNormal];
        [_suffixbtn_iphone setTitle:_soapResults forState:UIControlStateNormal];
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"FirstName"])
    {
        recordResults = FALSE;
        _firstnametxtfld.text=_soapResults;
        _firstnametxt_iphone.text=_soapResults;
        _soapResults=nil;    }
    
    if([elementName isEqualToString:@"LastName"])
    {
        recordResults = FALSE;
        _lastnametxtfld.text=_soapResults;
        _lastnametxt_iphone.text=_soapResults;
        _soapResults=nil;    }
    
    if([elementName isEqualToString:@"appAddress"])
    {
        recordResults = FALSE;
        _Addresstxtfld.text=_soapResults;
        _homeaddresstxt_iphone.text=_soapResults;
        _soapResults=nil;    }
       
    if([elementName isEqualToString:@"City"])
    {
        recordResults = FALSE;
        _citytxtfld.text=_soapResults;
        _citytxt_iphone.text=_soapResults;
        _soapResults=nil;    }
    
    if([elementName isEqualToString:@"StateName"])
    {
        recordResults = FALSE;
       
           [_statebtnlbl setTitle:_soapResults forState:UIControlStateNormal];
        [_statebtn_iphone setTitle:_soapResults forState:UIControlStateNormal];
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"Zip"])
    {
        recordResults = FALSE;
        _ziptextflield.text=_soapResults;
        _ziptxt_iphone.text=_soapResults;

        _soapResults=nil;    }
    
    
      
    if([elementName isEqualToString:@"SSN"])
    {
        recordResults = FALSE;
        _ssntxtfld.text=_soapResults;
        _ssntextfield_iphone.text=_soapResults;

        _soapResults=nil;    }
    
    
    
    if([elementName isEqualToString:@"DOB"])
    {
        recordResults = FALSE;
        NSArray *dateArray=[[NSArray alloc]init];
        dateArray=[_soapResults componentsSeparatedByString:@"T"];
        NSString *date1 =[dateArray objectAtIndex:0];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *dates = [dateFormat dateFromString:date1];
        [dateFormat setDateFormat:@"MM-dd-yyy"];
        NSString *myFormattedDate = [dateFormat stringFromDate:dates];

      
        [_dobbtnlbl setTitle:myFormattedDate forState:UIControlStateNormal];
        _dobtext_iphone.text=myFormattedDate;
        _soapResults=nil;    }
    
    
    
    
    if([elementName isEqualToString:@"CountryName"])
    {
        recordResults = FALSE;
          [_countrybtnlbl setTitle:_soapResults forState:UIControlStateNormal];
          [_countrytxt_iphone setTitle:_soapResults forState:UIControlStateNormal];
        _soapResults=nil;
    }
    
    
    if([elementName isEqualToString:@"Gender"])
    {
        recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            _gendersegmentcntrl.selectedSegmentIndex=0;
            _gendersegment_iphone.selectedSegmentIndex=0;
            
            
        }
        else  if ([_soapResults isEqualToString:@"false"]) {
            _gendersegmentcntrl.selectedSegmentIndex=1;
            _gendersegment_iphone.selectedSegmentIndex=1;
            
            
        }

        
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"Email"])
    {
        recordResults = FALSE;
        _emailtxtfld.text=_soapResults;
        _emailtxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    
    if([elementName isEqualToString:@"CellphoneNo"])
    {
        recordResults = FALSE;
        _mobiletxtfld.text=_soapResults;
        _mobilenotext_iphone.text=_soapResults;
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"PhoneNo"])
    {
        recordResults = FALSE;
        _homenumbertxtfld.text=_soapResults;
        _homenotxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    
    if([elementName isEqualToString:@"AlternateNo"])
    {
        recordResults = FALSE;
        _alternativenumtxtfld.text=_soapResults;
        _alternatenotxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"EmergencyContactName"])
    {
        recordResults = FALSE;
        _emergencytxtfld.text=_soapResults;
        _emergencycontactnametxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"EmergencyContactNo"])
    {
        recordResults = FALSE;
        _contactnumbtxtfld.text=_soapResults;
        _contactnotxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    

    
    if([elementName isEqualToString:@"DrivingLicenseNo"])
    {
        recordResults = FALSE;
        _driverlicencetxtfld.text=_soapResults;
        _drivinglicenceno_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    
    
    if([elementName isEqualToString:@"LicenseIssuingState"])
    {
        recordResults = FALSE;
        _stateissuetxtfld.text=_soapResults;
        _stateissuetxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"NameInLicense"])
    {
        recordResults = FALSE;
        _nameinlicencetxtfld.text=_soapResults;
        _nameonlicenct_iphone.text=_soapResults;
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"state_id"])
    {
        recordResults = FALSE;
       
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"state_abbr"])
    {
        recordResults = FALSE;
        
        _soapResults=nil;
    }

    if([elementName isEqualToString:@"state_name"])
    {
        recordResults = FALSE;
        NSLog(@"%@",_soapResults);
        [_stateArray addObject:_soapResults];
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"url"])
    {
        
        recordResults = FALSE;
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:_soapResults delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        _soapResults = nil;
    }


    

}
-(void)createPopover
{
    popovertype=2;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 200, 250)];
    
    popoverView.backgroundColor = [UIColor lightTextColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, 250)];
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
    _popOverTableView.separatorColor=[UIColor cyanColor];
    
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(200, 250);
    
    //create a popover controller
    self.popOverController1 = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    [self.popOverController1 presentPopoverFromRect:_statebtnlbl.frame
                                            inView:self.scrollview
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
  
}

#pragma mark - Calendar
-(void)createCalenderPopover
{
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 315, 330)];
    
    popoverView.backgroundColor = [UIColor lightTextColor];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(315, 330);
    
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = (id)self;
    
    
    NSDate *date = [NSDate date];
    
    // format it
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    
    // convert it to a string
    NSString *dateString = [dateFormat stringFromDate:date];
    //NSLog(@"datestring%@",dateString);
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    calendar.selectedDate = [self.dateFormatter dateFromString:dateString];
    
    calendar.minimumDate = [self.dateFormatter dateFromString:@"09/07/2011"];
    calendar.maximumDate =[self.dateFormatter dateFromString:@"1/07/2014"];
    calendar.shouldFillCalendar = YES;
    calendar.adaptHeightToNumberOfWeeksInMonth = NO;
    
    calendar.frame = CGRectMake(10, 10, 300, 320);
    [popoverView addSubview:calendar];
    
    //    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    //    [self.view addSubview:self.dateLabel];
    
    //  self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    //create a popover controller
    self.popOverController1 = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    [self.popOverController1 presentPopoverFromRect:_dobbtnlbl.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    
}




- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}



#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/YYYY"];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    [_dobbtnlbl setTitle:dateString forState:UIControlStateNormal];
    
}


//iphone
- (IBAction)detailbtn_iphone:(id)sender {
    if (detailbtnclicked_iphone==0) {
        _contactinfoview_iphone.hidden=NO;
        [_infobtn_iphone setImage:[UIImage imageNamed:@"disclsurebtn"] forState:UIControlStateNormal];
        detailbtnclicked_iphone=1;
        
    }
    
    else{
        _contactinfoview_iphone.hidden=YES;
        [_infobtn_iphone setImage:[UIImage imageNamed:@"disclsurebtndwn"] forState:UIControlStateNormal];
        
        
    detailbtnclicked_iphone=0;
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if([pickerstring isEqualToString:@"suff"])
    {
        return [_suffixarray_iphone count];
    }
    else
    {
        return [_stateArray count];
    }
    return YES;

}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if([pickerstring isEqualToString:@"suff"])
    {
        return [_suffixarray_iphone objectAtIndex:row];
    }
    else if([pickerstring isEqualToString:@"state"])
    {
        return [_stateArray objectAtIndex:row];
    }

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
      if([pickerstring isEqualToString:@"suff"])
      {
    [ _suffixbtn_iphone setTitle:[_suffixarray_iphone objectAtIndex:row] forState:UIControlStateNormal];
          _suffixpicker.hidden=YES;

      }
     else if([pickerstring isEqualToString:@"state"])
     {
    [ _statebtn_iphone setTitle:[_stateArray objectAtIndex:row] forState:UIControlStateNormal];
         _statepicker.hidden=YES;

     }
   
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}
-(IBAction)selectsuffix_iphone:(id)sender
{   pickerstring=@"suff";
    _suffixpicker.hidden=NO;
    [_suffixpicker reloadAllComponents];
}
-(IBAction)selectstate_iphone:(id)sender
{
    
    pickerstring=@"state";
    
    _statepicker.hidden=NO;
    [_statepicker reloadAllComponents];
;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    
    
    if (textField==_dobtext_iphone) {
        
        [_dobtext_iphone resignFirstResponder];
        
        _datepicker_iphone.hidden=NO;
        
        [_datepicker_iphone addTarget:self action:@selector(picker1action) forControlEvents:UIControlEventValueChanged];
    }
    //_picker.hidden=YES;
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==_dobtext_iphone) {
        
        
        [_dobtext_iphone resignFirstResponder];
        
        _datepicker_iphone.hidden=NO;
        
        
        [  _datepicker_iphone addTarget:self action:@selector(picker1action) forControlEvents:UIControlEventValueChanged];
    }
    
    //_picker.hidden=YES;
    return YES;
}
-(void)picker1action{
    NSDate *date1  = _datepicker_iphone.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
//    dateFormat.dateFormat=@"MM/dd/yyyy";
    dateFormat.dateFormat=@"yyyy-MM-dd";
    _dobtext_iphone.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date1]];
    _datepicker_iphone.hidden=YES;
    
}

-(IBAction)update_iphone:(id)sender
{
    [self UpdateApplicantData];

}
-(IBAction)cancel_iphone:(id)sender
{
    
}
#pragma mark - Uploadimage


-(void)UploadImage{
    recordResults = FALSE;
    NSString *soapMessage;
    NSString *imagename=@"abc.png";
    // NSString *cmpnyname=@"webserv";
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UploadImage xmlns=\"http://webserv.kontract360.com/\">\n"
                   "<f>%@</f>\n"
                   "<fileName>%@</fileName>\n"
                   
                   "</UploadImage>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_encodedString,imagename];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://webserv.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://webserv.kontract360.com/UploadImage" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}



- (void)handlePinch:(UITapGestureRecognizer *)pinchGestureRecognizer
{
    //handle pinch...
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        
        
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.showsCameraControls=YES;
        
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        // imagePicker.cameraCaptureMode=YES;
        [self presentModalViewController:imagePicker
                                animated:YES];
        _newMedia = YES;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // [self.popoverController dismissPopoverAnimated:true];
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    
    
    
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        NSLog(@"dict%@",info);
        
        
        _imgvw.image =image;
        [self dismissModalViewControllerAnimated:YES];
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    
    
    
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    else{
        
        [self dismissModalViewControllerAnimated:YES];
        
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    // [self dismissModalViewControllerAnimated:YES];
    
}


- (IBAction)uploadimage:(id)sender {
    UIImage *image =_imgvw.image;
    NSData *data = UIImagePNGRepresentation(image);
    _encodedString = [data base64EncodedString];
    
    NSLog(@"result%@",_encodedString);
    
    [self UploadImage];

    
}
@end
