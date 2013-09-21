ofxFacebook
===========



ofxFacebook allows easy implementation of Facebook SDK 3.0 with OF in a simple C++ environment.


This Addon is currently compatible with IOSX, future versions of this will support other devices



Who is this addon for?


People who want to:


Post a comment,link,picture,ofImages on their Facebook walls from their mobile devices,


Simply by doing   Facebook.post(.......);


the post function uses a smart template algorithm that automatically detects what the object is that you are posting.

if it's a url link a comment , an ofImage , or even a picture url form the web!



you can do


Facebook.post("http://myawesomeImage.png");


and it will post the image from the link


or you can do:


Facebook.post(myImage);

and post an image that you are processing in OF!


or you can be imaginative and post a comment with that image:


Facebook.post("hey check this out",ofImage);


or you can go over the top and post a comment a link and an image from the web in a single post!


Facebook.post("hey I am playing this game!","http://myawesomegame.com","http://mypic.png");



it also allows you to know if the user actually posted or declined

it allows you to check if the device is connected to the internet

it allows login-out and even modify the dialog of the process!



Requirements:

FACEBOOKSDK 3.0
A Facebook-App account!
OF 074+

See detailed guide on how to set it up in the PDF


Examples included.
