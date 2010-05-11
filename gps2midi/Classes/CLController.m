//
//  CLController.m
//  gps2midi
//
//  Created by Bryan Summersett on 5/11/10.
//  Copyright 2010 Student. All rights reserved.
//

#import "CLController.h"

@implementation CLController

@synthesize locationManager;

static const char *gRemoteHost = "foobar.com";

- (id) init {
    self = [super init];
    if (self != nil) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self; // send loc updates to myself
        loClient = lo_address_new(gRemoteHost, "1735");
    }
    return self;
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
    
    
    lo_send(loClient, "/gps","sddd", loc, dir, coords.latitude, coords.longitude, speed);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

- (void)dealloc {
    lo_address_free(loClient);
    [self.locationManager release];
    [super dealloc];
}

@end