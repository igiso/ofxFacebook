ofxFacebook
===========



ofxFacebook allows easy implementation of Facebook SDK 3.0 with OF in a simple C++ environment.


This Addon is currently compatible with IOSX, future versions will support other devices



Who is this addon for?


People who want to:


Post a comment,link,picture,ofImages on their Facebook walls from their apple mobile devices,


Simply by doing   Facebook.post(.......);


the post function uses a smart template algorithm that automatically detects the type of object you are posting.

Post anything from a url link , a comment , an ofImage , or even a picture url directly form the web!



you can do:


Facebook.post("http://www.photosite.com/myawesomeImage.png");


and it will post the image from the particular link


or you can do:


Facebook.post(myImage);

and post something that you are processing in your OF app!


you can be imaginative and post a comment with that image:


Facebook.post("hey check this out",ofImage);


or you can go over the top and post a comment + a link + an image from the web all in a single post!


Facebook.post("hey I am playing this game!","http://myawesomegame.com","http://mypic.png");



it also allows you to know if the user actually posted or declined

check if the device is connected to the internet

also login and logout and even modify the dialog of the whole process!



Requirements:

FACEBOOKSDK 3.0
A Facebook-App account!
OF 074+

See detailed guide on how to set it up in the PDF


Examples included.
