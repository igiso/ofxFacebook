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
    
    
    FaceBook->post("Icon.png","blabla");///post image from phone with text
    
    
     
  }


void testApp::launchedWithURL(string url){
    
    FaceBook->getAnswer(url); ////very important
    
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
 
 // ///POST TEXT WITH IMAGE FROM INTERNET WITH LINK!!:
 
 FaceBook->post("testing",////text title
 "http://i1216.photobucket.com/albums/dd367/kousoulides/1.jpg",///loadImage from Internet
 "https://itunes.apple.com/us/app/puzzle-flights-somewhere-inside/id549658406?mt=8"//link
 );

 
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
void testApp::draw()
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
