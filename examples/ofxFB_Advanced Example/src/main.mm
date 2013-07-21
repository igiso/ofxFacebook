#include "testApp.h"

/*
    Main function
*/
int main(){
	//set up anti-aliasing on the iOS window and runn the app
    ofAppiPhoneWindow *iOSWindow = new ofAppiPhoneWindow();
    iOSWindow->enableAntiAliasing(2);
    ofSetupOpenGL(iOSWindow, 480, 320, OF_FULLSCREEN);
    ofRunApp(new testApp);
}