//
//  gps2midiAppDelegate.m
//  gps2midi
//
//  Created by Bryan Summersett on 5/11/10.
//  Copyright Student 2010. All rights reserved.
//

#import "gps2midiAppDelegate.h"

static const char *gRemoteHost = "foobar.com";

@implementation gps2midiAppDelegate

@synthesize window, locationManager;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch
    loClient = lo_address_new(gRemoteHost, "1735");
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.delegate = self; // send loc updates to myself
    [self.locationManager startUpdatingLocation];
    
    
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
    const char *loc = [[newLocation description] UTF8String];
    CLLocationDirection dir = [newLocation course];
    CLLocationCoordinate2D coords = [newLocation coordinate];
    CLLocationSpeed speed  = [newLocation speed];
    
    
    lo_send(loClient, "/gps","sdddd", loc, dir, coords.latitude, coords.longitude, speed);
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}


- (void)dealloc {
    lo_address_free(loClient);
    [self.locationManager release];
    [window release];
    [super dealloc];
}


@end
