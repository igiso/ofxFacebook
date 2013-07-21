#include "testApp.h"


/*
 To compile this example
 Download FacebookSDK 3.0
 &install it
 
  Drag "FaceBookSDK.frameworks" from Documents/Facebooksdk/ (standard installed location)
  
 
 */

void testApp::setup()
{
    
    
    ofxiPhoneAlerts.addListener(this);///don't forget this
    
    FaceBook = new ofxFacebook();
    
    
    
    
    
    ///Set your own personal message to the user:
    
    FaceBook->setTitleofMessage("You have Grabbed 100 Stars!");
    FaceBook->setBodyofMessage("Share your achivement to ""%@"" Account?");
    
    //Set ID of Post to do stuff with positive answer
    
    FaceBook->setPostID(333);//you can use any number you like
    
    
    
    
    // ///POST TEXT WITH IMAGE FROM INTERNET WITH LINK!!:
    FaceBook->post("testing",////text title
                   "http://i1216.photobucket.com/albums/dd367/kousoulides/1.jpg",///loadImage from Internet
                   "https://itunes.apple.com/us/app/puzzle-flights-somewhere-inside/id549658406?mt=8"//link
                   );
    
  }


void testApp::launchedWithURL(string url){
    
    FaceBook->getAnswer(url); ////very important
    
}


void testApp::draw()
{
    

    
    if(FaceBook->gotPositiveAnswer(333)){
        
        ofDrawBitmapString("You have unlocked something awesome", 20,ofGetHeight()/2);
        
    }
    
    
    
    
}

testApp::~testApp()
{
    delete FaceBook;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////ofxFacebook Addon\\\\\\\\\\\\\\\\\\\\


/*

 
 To add this addon to your own project :
 
 
 
 MAKE SURE THAT YOUR APP RUNS IN BACKGROUND  
 
 MAKE YOUR OWN FACEBOOKAPP ID (see pdf)
 
 Modify your .plist like in this Example
  
 Add the 4 Frameworks:
 
 * "FaceBookSDK.frameworks" (drag it)
 * "Accounts.framework" 
 * "libsqlite3.dylib"
 * "SystemConfiguration.framework"
 
 Add  the addon - include it
 
 
 
 
 //_________HOW TO POST:
 
 
 //post simple image:
 
 
 //   FaceBook->postImg("Default.png");
 
 ofImage  i;
 i.loadImage("Icon.png");
 
 FaceBook->post(i,"blabla");///post image from phone with text
 
 //_________OR:
 
 FaceBook->post("blabla");///post just text ,just URL, etc..
 
 You just paste whatever you want FROM:  (URL LINK, IMAGE, DIRECT IMAGE LINK, TEXT) inside ofxFacebook::Post() and it will post it:
 
 NOTE:
 
 You can't post LINK & image from your phone, that is not allowed by Facebook
 
 you can post image from web, with url link and with text
 
 
 
 
 
 
//



*/
/////////////////////////////////////////////////////////////////////////////////////////////////////


void testApp::update()
{
}

void testApp::exit()
{
}
void testApp::touchDown(ofTouchEventArgs &touch)
{
}
void testApp::touchMoved(ofTouchEventArgs &touch)
{
}
void testApp::touchUp(ofTouchEventArgs &touch)
{
}
void testApp::touchDoubleTap(ofTouchEventArgs &touch)

{   
}
void testApp::lostFocus()
{
}
void testApp::gotFocus()
{    
}
void testApp::gotMemoryWarning()
{
}
void testApp::touchCancelled(ofTouchEventArgs &touch)
{    
}
