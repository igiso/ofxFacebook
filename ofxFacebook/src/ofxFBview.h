//
//  ofxFBview.h
//  Butterflyhd
//
//  Created by kyriacos on 7/3/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#ifndef ofxFBview_h
#define ofxFBview_h


#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

#define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"



typedef enum {
	NotReachable = 0,
	ReachableViaWiFi =1,
	ReachableViaWWAN =2
} NetworkStatus;


@interface Reachability: NSObject
{
	BOOL localWiFiRef;
	SCNetworkReachabilityRef reachabilityRef;
}

+ (Reachability*) reachabilityWithHostName: (NSString*) hostName;

+ (Reachability*) reachabilityWithAddress: (const struct sockaddr_in*) hostAddress;

+ (Reachability*) reachabilityForInternetConnection;

+ (Reachability*) reachabilityForLocalWiFi;

- (BOOL) startNotifier;
- (void) stopNotifier;

- (NetworkStatus) currentReachabilityStatus;

- (BOOL) connectionRequired;
@end





#endif
