//
//  AppContextTestClass.m
//  CSMysteryChallenge
//
//  Created by Chris Wineland on 8/24/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppContext.h"


@interface AppContextTestClass : XCTestCase

@end

@implementation AppContextTestClass

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (AppContext *)getSingleton {
    //helper function to test the singleton
    return [AppContext singleton];
}

- (void)testSingletonInit{
    XCTAssert([self getSingleton], @"When singleton is called on AppContext, it should return an initialized object");
}

-(void)testClearingDataSet{
    [[[self getSingleton] fullDataSet]addObject:[[NSObject alloc]init]];
    XCTAssert([[[self getSingleton] fullDataSet]count] > 0, @"After an object has been added to the full data set, it should persist");
    [[self getSingleton] clearDataSet];
    XCTAssertEqual([[[self getSingleton] fullDataSet]count], (NSUInteger)0, @"After clearing the full data set, it should contain no objects");
}

@end
