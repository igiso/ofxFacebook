//
//  ofxFB.h
//  Butterflyhd
//
//  Created by kyriacos on 7/2/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////ofxFacebook Addon\\\\\\\\\\\\\\\\\\\\


/*
 
 ofxFB checks if there is an internet connection and then tries to post your image or status on Facebook.
 
feel free to expand and modify the code
 
 
 
 To add this addon to your project :
 
 
 
 
 MAKE SURE THAT YOUR APP RUNS IN BACKGROUND  
 
 MAKE YOUR OWN FACEBOOKAPP ID (see pdf)
 
 Modify your .plist like in this Example
 
 
 Drag: "FaceBookSDK.frameworks"  to CoreFrameworks
 
 Add Frameworks: "Accounts.framework" , "libsqlite3.dylib",
 "SystemConfiguration.framework"
 
 Add addon - include it
 
 
 */
/////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef ofxFB_h
#define ofxFB_h


#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#import <FacebookSDK/FacebookSDK.h>
#import <UIKit/UIKit.h>
#import "ofxFBview.h"

extern bool POST_IN_PROCESS;

typedef enum {
    NOTHING______=0,
    POSITIVE_____=1,
    NEGATIVE_____=2
}_Answer;

class FB_Answer{
  public:
    _Answer answer;
    int  tagID;
};

extern vector <FB_Answer> FB_Answers;

typedef void(^FacebookLoginCompletionBlock)(id<FBGraphUser> user);


@interface FaceBookControl : UIView {
    int tagID_;
    NSString *myStatus;
    NSString *myUrl;
    NSString *imgURL;
    NSString *text;
    UIActivityIndicatorView *activity;
     NSString* PathofImg;
    UIImage *image;
    BOOL usePath,useUrl,useURLIMG,useText,useRealIMG;
    FBSession *mySession;
    
    NSString * firstMessage, *secondMessage;
}

- (void)loginToFacebookFromWithCompletionBlock:(FacebookLoginCompletionBlock)completionBlock;

-(void)uploadPhoto;
-(void)uploadPhoto: (UIImage *) im ;
-(void)uploadPhotoFromPath: (NSString *) path;
-(void)updateStatus;
-(void)updateStatus:(NSString *) message;
-(void)postIMGwithText:(NSString *) message image:(NSString*)path;
-(void)addURL:(NSString*)url;
-(void)addPhoto:(UIImage*)imag_;
-(void)postIMGfromURL:(NSString*)imgUrl_;
-(void)postText:(NSString *)text;
-(void)postIMGTXT;
-(void)dealloc;

@end


typedef enum {
    TEXT_,URL_,IMGpath_,IMGLINK_,NOTHING_,ofIMG_
}FBDATA;



class ofxFb {
    NSString *URLaddress;
    NSString *PathofImg;
    NSString * NSSmessage;
    bool allocated;
    bool ignoreInternet_;
public:
    void add_tagID(int tagId_);
    _Answer getResponseOfUser(int tagID_);
    Reachability* internetReach;
    bool createFB();
    void addIMG(ofImage im);
    void addIMG(ofImage *im);
    void addIMG(string path);
    void addIMGURL(string path);
    void addText(string text);
    void addURL(string url);
    virtual void addIMGURL(ofImage path){}
    virtual void addText(ofImage text){}
    virtual void addURL(ofImage url){}
    virtual void addIMGURL(ofImage *path){}
    virtual void addText(ofImage *text){}
    virtual void addURL(ofImage *url){}
    void goPost();
    FaceBookControl *fb;
    ofxFb();
    ~ofxFb();
    bool isConnected();
    void ignoreInternet();
    NetworkStatus connectionStatus();
    string connectionType();  
    void getAnswer(string url);
    void setTitleOfMessage(string url);
    void setBodyOfMessage(string url);

};

class string2{
    public:
    string s;
    void append(string s_){
        s = s_;
    }
   virtual void append(ofImage *i){}
    virtual void append(ofImage i){}
        
};

class ofxFacebook{
    template <class T>
    FBDATA getType(T atype){
        FBDATA  type= TEXT_;
if((strncmp(typeid(atype).name(),"P8ofImage_IhE",12)==0)||(strncmp(typeid(atype).name(),"8ofImage_IhE",12)==0)){ 
    type = ofIMG_;
}else {    
    string2 a;
    a.append(atype);
            if(a.s!="0"){
                size_t png__t_ = a.s.find(".png");
                size_t jpg__t_ = a.s.find(".jpg");
                if (png__t_!=string::npos||jpg__t_!=string::npos)type = IMGpath_;
                size_t url_t = a.s.find("http");                   
                if(url_t !=string::npos&&type== IMGpath_)type =IMGLINK_;
                if(url_t !=string::npos&&type== TEXT_)type=URL_;
            }else type = NOTHING_;
            
        }
        return  type;
    }
    template <class T,class I>
    void act(I atype){
        T type = atype;
        act(type);
    }
    template <class T>
    void act(T atype){
        FBDATA d = getType(atype);
        switch (d) {
            case IMGpath_:
                book->addIMG(atype);
                break;
            case IMGLINK_:
                book->addIMGURL(atype);
                break;
            case TEXT_: 
                book->addText(atype);
                break;
            case URL_:
                book->addURL(atype);
                break;
            case ofIMG_:
                book->addIMG(atype);
                break;
            default:
                break;
        }
        
    }
    ofxFb *book;
    public:
    void setPostID(int post_ID){
        book->add_tagID(post_ID);
    }
    bool gotPositiveAnswer(int post_ID){
        bool answer;
        if(book->getResponseOfUser(post_ID)==POSITIVE_____)answer =true; else answer = false;
        return answer;
    }
    ofxFacebook(){book = new ofxFb();}
    ~ofxFacebook(){delete book;}
    void setTitleofMessage(string title){book->setTitleOfMessage(title);}
    void setBodyofMessage(string body){book->setBodyOfMessage(body);}
    void getAnswer(string url){book->getAnswer(url);}
    bool isConnected(){return book->isConnected();}
    void ignoreInternet(){book->ignoreInternet();}
    template <class T,class I>
    void post(I a,T b="0",T c="0"){
        this->act(a); 
        this->act(b);
        this->act(c);
        book->goPost();
    }
    template <class T>
    void post(T a){
        this->act(a); 
        book->goPost();
    }

    
};




#endif
