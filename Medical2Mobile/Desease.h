//
//  Desease.h
//  Medical2Mobile
//
//  Created by LISComputer on 04.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient, PossibleICDNumber, User;

@interface Desease : NSManagedObject

@property (nonatomic, retain) NSDate * dateinsert;
@property (nonatomic, retain) NSDate * datestart;
@property (nonatomic, retain) NSString * longdescription;
@property (nonatomic, retain) Patient *patient;
@property (nonatomic, retain) PossibleICDNumber *possibleicdnumber;
@property (nonatomic, retain) User *user;

@end
