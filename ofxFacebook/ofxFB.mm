//
//  ofxFB.mm
//  Butterflyhd
//
//  Created by kyriacos on 7/2/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#include <iostream>

#include "ofxFB.h"


bool POST_IN_PROCESS=false;
vector <FB_Answer> FB_Answers;

@interface FaceBookControl ()

@end

@implementation FaceBookControl

-(void)alloc{
    tagID_=0;
    image=nil;
    usePath=NO;
    myStatus=nil;
    useUrl=NO;
    useText=NO;
    useURLIMG=NO;
    useRealIMG=NO;
    activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    CGPoint p;
    p = ofxiPhoneGetGLView().center;
    activity.center = p;
    [ofxiPhoneGetGLView() addSubview: activity];
    [activity bringSubviewToFront:ofxiPhoneGetGLView()];
    firstMessage =[[NSString alloc]initWithString:@"Post to Facebook?"];
    secondMessage=[[NSString alloc]initWithString:@"Publish status to ""%@"" Account?"];
    
}

-(void)tagPostTogetAnswer:(int) tag{    
    FB_Answer a;
    a.tagID = tag;
    a.answer = NOTHING______;
    FB_Answers.push_back(a);
    tagID_ = tag;
}
-(_Answer)getAnswer:(int)tag{
    _Answer answer;
for (int i=0; i<FB_Answers.size(); i++) {
if(tag==FB_Answers[i].tagID)answer = FB_Answers[i].answer; else answer = NOTHING______;
}
    return answer;
}

-(void)setFirstMessage:(NSString *)message{
    [firstMessage release];
    firstMessage = [[NSString alloc] initWithString:message];
}
-(void)setBodyofMessage:(NSString *)body{
    [secondMessage release];
    secondMessage = [[NSString alloc] initWithString:body];
}

-(void)dealloc {
    [activity release];

}
-(void)reset{
    image=nil;
    usePath=NO;
    myStatus=nil;
    useUrl=NO;
    useText=NO;
    useURLIMG=NO;
    useRealIMG=NO;

}

-(void)controlStatusUsable:(BOOL)usable {
    if (usable) {
        self->activity.hidden = YES;
        [self->activity stopAnimating];
    } else {
        self->activity.hidden = NO;
        [self->activity startAnimating];
    }
    
}

-(void)promptUserWithAccountNameForUploadPhoto {
    
    [self controlStatusUsable:NO];
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
         if (!error) {
             
             UIAlertView *tmp = [[UIAlertView alloc] 
                                 initWithTitle:@"Upload to FB?" 
                                 message:[NSString stringWithFormat:@"Upload to ""%@"" Account?", user.name]
                                 delegate:self 
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"No",@"Yes", nil];
             tmp.tag = 100; // to upload
             [tmp show];
             [tmp release];
             
         }
         
         [self controlStatusUsable:YES];
     }];  
}


-(void)promptUserWithAccountNameForStatusUpdate {
    [self controlStatusUsable:NO];
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
         if (!error) {
             
             UIAlertView *tmp = [[UIAlertView alloc] 
                                 initWithTitle:@"Publish to FB?" 
                                 message:[NSString stringWithFormat:@"Publish status to ""%@"" Account?", user.name]
                                 delegate:self 
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"No",@"Yes", nil];
             tmp.tag = 200; // to update status
             [tmp show];
             [tmp release];
             
         }
         
         [self controlStatusUsable:YES];
     }];  
}
-(void)promptUserforPOSTIMGWITHTEXT {
    [self controlStatusUsable:NO];
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
         if (!error) {
             
             UIAlertView *tmp = [[UIAlertView alloc] 
                                 initWithTitle:firstMessage 
                                 message:[NSString stringWithFormat:secondMessage, user.name]
                                 delegate:self 
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"No",@"Yes", nil];
             tmp.tag = 300; // to update status
             [tmp show];
             [tmp release];
             
         }
         
         [self controlStatusUsable:YES];
     }];  
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (buttonIndex==1) { // yes answer
        if (alertView.tag==100) {
            if(usePath){image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource: PathofImg ofType:nil]];
                [PathofImg release];}
            [self controlStatusUsable:NO];
            [FBRequestConnection startForUploadPhoto:image 
                                   completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                       if (!error) {

                                           UIAlertView *tmp = [[UIAlertView alloc] 
                                                               initWithTitle:@"Success" 
                                                               message:@"Photo Uploaded"
                                                               delegate:self 
                                                               cancelButtonTitle:nil
                                                               otherButtonTitles:@"Ok", nil];
                                           
                                           [tmp show];
                                           [tmp release];
                                       } else {

                                           UIAlertView *tmp = [[UIAlertView alloc] 
                                                               initWithTitle:@"Error" 
                                                               message:@"Some error happened"
                                                               delegate:self 
                                                               cancelButtonTitle:nil
                                                               otherButtonTitles:@"Ok", nil];
                                           
                                           [tmp show];
                                           [tmp release];
                                       }
                                       
                                       [self controlStatusUsable:YES];
                                   }];
            if (!usePath)[image release];

        }
        
        if (alertView.tag==200) {
            // the post status
            
            [FBRequestConnection startForPostStatusUpdate:myStatus completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    UIAlertView *tmp = [[UIAlertView alloc] 
                                        initWithTitle:@"Success" 
                                        message:@"Status Posted"
                                        delegate:self 
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"Ok", nil];
                    
                    [tmp show];
                    [tmp release];
                } else {
                    UIAlertView *tmp = [[UIAlertView alloc] 
                                        initWithTitle:@"Error" 
                                        message:@"Some error happened"
                                        delegate:self 
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"Ok", nil];
                    
                    [tmp show];
                    [tmp release];
                }
            }];
        
            [myStatus release];
            
        }
        
        
        if (alertView.tag==300){
            NSString * StartWithGPath = [[NSString alloc ]init];
            if(usePath){
                image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource: PathofImg ofType:nil]];
                [PathofImg release];   
                StartWithGPath = @"me/photos";

            }else{StartWithGPath = @"me/feed";}

            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
                                     
           if(useUrl){[params setObject:myUrl forKey:@"link"];
            if(useText)[params setObject:myStatus forKey:@"message"];
            if(useURLIMG)[params setObject:imgURL forKey:@"picture"];

           }else {
            if(useText)[params setObject:myStatus forKey:@"message"];
            if(usePath||useRealIMG){[params setObject:image forKey:@"picture"];StartWithGPath = @"me/photos";}
            if(useURLIMG)[params setObject:imgURL forKey:@"picture"];
           }
            
            
            [FBRequestConnection startWithGraphPath:StartWithGPath
                                         parameters:params
                                         HTTPMethod:@"POST"
                                  completionHandler:^(FBRequestConnection *connection,
                                                      id result,
                                                      NSError *error) {
                if (!error) {
if(FB_Answers.size()>0){
for (int i=0; i<FB_Answers.size(); i++){
if(FB_Answers[i].tagID == tagID_)FB_Answers[i].answer = POSITIVE_____;
}
}
                    UIAlertView *tmp = [[UIAlertView alloc] 
                                        initWithTitle:@"Success" 
                                        message:@"Thanks for sharing!"
                                        delegate:self 
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"Ok", nil];
                    
                    [tmp show];
                    [tmp release];
                } else {
                    if(FB_Answers.size()>0){
                        for (int i=0; i<FB_Answers.size(); i++){
                            if(FB_Answers[i].tagID == tagID_)FB_Answers[i].answer = NOTHING______;
                        }
                    }                    UIAlertView *tmp = [[UIAlertView alloc] 
                                        initWithTitle:@"Error" 
                                        message:@"Some error happened"
                                        delegate:self 
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"Ok", nil];
                    
                    [tmp show];
                    [tmp release];
                }
            }];
            if(useText)[myStatus release]; 
            if(useUrl)[myUrl release];
            if(usePath||useRealIMG)[image release];
            if (useURLIMG)[imgURL release];
            [StartWithGPath release];
            POST_IN_PROCESS=false;
            [self reset];

        }
        
    }else{
    if(buttonIndex==0&&alertView.tag==300){        
        if(FB_Answers.size()>0){
        for (int i=0; i<FB_Answers.size(); i++){
      if(FB_Answers[i].tagID == tagID_)FB_Answers[i].answer = NEGATIVE_____;
        }
        }
    }    
    
    }
}
-(void)addPhoto:(UIImage *)imag_{
    image = [[UIImage alloc] initWithCGImage:imag_.CGImage];
    useRealIMG=YES;
    
}

-(void)uploadPhoto: (UIImage *) im{
    
    image = [[UIImage alloc] initWithCGImage:im.CGImage];
    usePath=NO;
    [self uploadPhoto];
    
}

-(void)uploadPhotoFromPath:(NSString *)path{
PathofImg = [[NSString alloc]initWithString:path];
    usePath = YES;
    [self uploadPhoto];
}
-(void)addIMGFromPath:(NSString *)path{
    PathofImg = [[NSString alloc]initWithString:path];
    usePath = YES;
}

-(void)updateStatus:(NSString *) message{
    
myStatus = [[NSString alloc]initWithString:message];

    [self updateStatus];
    

}
-(void)postIMGwithText:(NSString *) message image:(NSString*)path{
    
    myStatus = [[NSString alloc]initWithString:message];
    PathofImg = [[NSString alloc]initWithString:path];
    usePath = YES;
    
    [self postIMGTXT];
    
}



-(void)uploadPhoto {
    
    if (FBSession.activeSession.isOpen) {
        
        
        [self promptUserWithAccountNameForUploadPhoto];
        
        
    } else {
        
        
             
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"publish_stream",
                                nil];
        [self controlStatusUsable:NO];
        // OPEN Session!
        
        [FBSession openActiveSessionWithPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, 
                                                      FBSessionState status, 
                                                      NSError *error) {
                                      if (error) {
                                          
                                printf("ofxFB:: DIDNT POST\n");            
                                          
                                      } else if (FB_ISSESSIONOPENWITHSTATE(status)) {
                                          [self promptUserWithAccountNameForUploadPhoto];                                              
                                      }
                                      [self controlStatusUsable:YES];
                                  }];
    }
}

-(void)postIMGTXT{
    
    
    
    
    if (FBSession.activeSession.isOpen) {
        
        
        [self promptUserforPOSTIMGWITHTEXT];        
        
    } else {
        
        
        
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"publish_stream",
                                nil];
        [self controlStatusUsable:NO];
        // OPEN Session!
        
        [FBSession openActiveSessionWithPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, 
                                                      FBSessionState status, 
                                                      NSError *error) {
                                      if (error) {
                                          
                                          printf("ofxFB:: DIDNT POST\n");            
                                          
                                      } else if (FB_ISSESSIONOPENWITHSTATE(status)) {
                                          [self promptUserforPOSTIMGWITHTEXT];        
                                      }
                                      [self controlStatusUsable:YES];
                                  }];
    }
    
    
    
    
}

-(void)addURL:(NSString *)url{
    myUrl = [[NSString alloc]initWithString:url];
    useUrl=YES;
}
-(void)postIMGfromURL:(NSString*)imgUrl_{
    
    imgURL = [[NSString alloc]initWithString:imgUrl_];
    useURLIMG=YES;
    
}
-(void)postText:(NSString *)text{
    myStatus = [[NSString alloc]initWithString:text];
    useText=YES;
    [self postIMGTXT];
    
}
-(void)addText:(NSString *)text{
    myStatus = [[NSString alloc]initWithString:text];
    useText=YES;
}
-(void)goPost{
[self postIMGTXT];

}


-(void)updateStatus {
    
    if (FBSession.activeSession.isOpen) {
        
        
        [self promptUserWithAccountNameForStatusUpdate];
        
        
    } else {
        
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"publish_stream",
                                nil];
        [self controlStatusUsable:NO];
        
        [FBSession openActiveSessionWithPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, 
                                                      FBSessionState status, 
                                                      NSError *error) {
                                      printf("ofxFB:: DIDNT POST \n");            
                                      if (error) {
                                          
                                          
                                      } else if (FB_ISSESSIONOPENWITHSTATE(status)) {
                                          
                                          [[FBRequest requestForMe] startWithCompletionHandler:
                                           ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                                               if (!error) {
                                                  
                                                   [self promptUserWithAccountNameForStatusUpdate];
                                                   
                                               }
                                               [self controlStatusUsable:YES];
                                           }];                                                
                                      }
                                  }];
    }
    
    
}

- (void)viewDidLoad
{
        
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}





@end












ofxFb::ofxFb(){
    POST_IN_PROCESS=false;
    allocated=false;
    ignoreInternet_=false;
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifier];
if(isConnected()){    
fb =  [FaceBookControl new];
    fb.alloc;
PathofImg =nil;
NSSmessage=nil;  
allocated=true;
    cout<<"ofxFB::CREATING THE OFXFB"<<endl;
    }else cout<<"ofxFB::NO INTERNET"<<endl;
    
}


void ofxFb::add_tagID(int idtag_){
    
    [fb tagPostTogetAnswer:idtag_];
}
_Answer ofxFb::getResponseOfUser(int tagID){
    
    return [fb getAnswer:tagID];
}

bool ofxFb::createFB(){
    if(isConnected()&&!allocated){    
        fb =  [FaceBookControl new];
        PathofImg =nil;
        NSSmessage=nil;  
        allocated=true;
        cout<<"ofxFB:: CREATING THE OFXFB"<<endl;
    }
    
    return allocated;

}


ofxFb::~ofxFb(){
    if (allocated) {
    [FBSession.activeSession close];
    [fb dealloc];
    allocated=false;//case someone tries to run this in a loop
    }
    [internetReach stopNotifier];
    
}


void ofxFb::addIMG(ofImage *photo){
    if(isConnected()&&createFB()){    
        if (!photo->isAllocated()) {
        } else{ 
            if(!POST_IN_PROCESS){
                CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, photo->getPixels(), (photo->getWidth()*photo->getHeight()*3), NULL);
                CGImageRef imageRef = CGImageCreate(photo->getWidth(), photo->getHeight(), 8, 24, 3*photo->getWidth(), CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrderDefault, provider, NULL, NO, kCGRenderingIntentDefault);
                NSData *imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:imageRef]);
                UIImage *output = [UIImage imageWithData:imageData];
                [fb addPhoto:output];
                
            }
        }
    }
    
}

void ofxFb::addIMG(ofImage photo){
    if(isConnected()&&createFB()){    
        if (!photo.isAllocated()) {
        } else{ 
            if (!POST_IN_PROCESS) {
                CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, photo.getPixels(), (photo.getWidth()*photo.getHeight()*3), NULL);
                CGImageRef imageRef = CGImageCreate(photo.getWidth(), photo.getHeight(), 8, 24, 3*photo.getWidth(), CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrderDefault, provider, NULL, NO, kCGRenderingIntentDefault);
                NSData *imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:imageRef]);
                UIImage *output = [UIImage imageWithData:imageData];
                
                [fb addPhoto:output];
            }
        }
    }
    
    
    
}



void ofxFb::addIMG(string path){
    if(isConnected()&&createFB()){ 
        if (!POST_IN_PROCESS) {        
            PathofImg = [[NSString alloc]initWithString:[NSString stringWithCString:path.c_str() encoding:NSASCIIStringEncoding]];
            [fb addIMGFromPath: PathofImg];
            [PathofImg release];
        }
    }
    
    
}
void ofxFb::addIMGURL(string path){
    if(isConnected()&&createFB()){ 
        if (!POST_IN_PROCESS) {        
            PathofImg = [[NSString alloc]initWithString:[NSString stringWithCString:path.c_str() encoding:NSASCIIStringEncoding]];
            [fb postIMGfromURL: PathofImg];
            [PathofImg release];
        }
    }
    
    
}


void ofxFb::addText(string text){

    NSSmessage = [[NSString alloc]initWithString:[NSString stringWithCString:text.c_str() encoding:NSASCIIStringEncoding]];
    [fb addText: NSSmessage];
    [NSSmessage release];
    
}
void ofxFb::addURL(string url){
    NSString *url_ = [NSString stringWithCString:url.c_str() encoding:NSASCIIStringEncoding];
    [fb addURL:url_];

}
void ofxFb::goPost(){
    [fb goPost];
    POST_IN_PROCESS=true;
}

void ofxFb::setBodyOfMessage(string url){
    NSString *url_ = [NSString stringWithCString:url.c_str() encoding:NSASCIIStringEncoding];
    [fb setBodyofMessage:url_];
    
}
void ofxFb::setTitleOfMessage(string url){
    NSString *url_ = [NSString stringWithCString:url.c_str() encoding:NSASCIIStringEncoding];
    [fb setFirstMessage:url_];

    
}

void ofxFb::getAnswer(string url){
    if(isConnected()&&createFB()){    
    NSString *urlData = [NSString stringWithUTF8String:url.c_str()];
    NSURL * _url = [NSURL URLWithString:urlData];
    cout<<"ofxFB:: AUTHENTICATING!!!!!!!!!!"<<endl;
    cout<< url<<endl;
    [FBSession.activeSession handleOpenURL:_url]; 
    }
    
}

bool ofxFb::isConnected(){
   
    if(!ignoreInternet_) return ![internetReach connectionRequired];else return true;
        
        
}


void ofxFb::ignoreInternet(){
    
    ignoreInternet_=true;
    
    if(!allocated){
        fb =  [FaceBookControl new];
        PathofImg =nil;
        NSSmessage=nil;  
        allocated=true;
    }
    
}
NetworkStatus ofxFb::connectionStatus(){
   
	
    return [internetReach currentReachabilityStatus];

}

