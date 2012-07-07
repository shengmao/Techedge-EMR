//
//  Patient.h
//  Medical2Mobile
//
//  Created by LISComputer on 03.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Patient : NSManagedObject

@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSString * lname;
@property (nonatomic, retain) NSString * mobilephone;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSSet *activity;
@property (nonatomic, retain) NSSet *adress;
@property (nonatomic, retain) NSSet *measurement;
@property (nonatomic, retain) NSSet *desease;
@property (nonatomic, retain) NSSet *document;
@property (nonatomic, retain) NSSet *insurance;
@property (nonatomic, retain) NSSet *stationary;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)addActivityObject:(NSManagedObject *)value;
- (void)removeActivityObject:(NSManagedObject *)value;
- (void)addActivity:(NSSet *)values;
- (void)removeActivity:(NSSet *)values;

- (void)addAdressObject:(NSManagedObject *)value;
- (void)removeAdressObject:(NSManagedObject *)value;
- (void)addAdress:(NSSet *)values;
- (void)removeAdress:(NSSet *)values;

- (void)addMeasurementObject:(NSManagedObject *)value;
- (void)removeMeasurementObject:(NSManagedObject *)value;
- (void)addMeasurement:(NSSet *)values;
- (void)removeMeasurement:(NSSet *)values;

- (void)addDeseaseObject:(NSManagedObject *)value;
- (void)removeDeseaseObject:(NSManagedObject *)value;
- (void)addDesease:(NSSet *)values;
- (void)removeDesease:(NSSet *)values;

- (void)addDocumentObject:(NSManagedObject *)value;
- (void)removeDocumentObject:(NSManagedObject *)value;
- (void)addDocument:(NSSet *)values;
- (void)removeDocument:(NSSet *)values;

- (void)addInsuranceObject:(NSManagedObject *)value;
- (void)removeInsuranceObject:(NSManagedObject *)value;
- (void)addInsurance:(NSSet *)values;
- (void)removeInsurance:(NSSet *)values;

- (void)addStationaryObject:(NSManagedObject *)value;
- (void)removeStationaryObject:(NSManagedObject *)value;
- (void)addStationary:(NSSet *)values;
- (void)removeStationary:(NSSet *)values;

@end
