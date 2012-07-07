//
//  PossibleICDNumber.h
//  Medical2Mobile
//
//  Created by LISComputer on 04.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Desease;

@interface PossibleICDNumber : NSManagedObject

@property (nonatomic, retain) NSNumber * field1_typOfCoding;
@property (nonatomic, retain) NSNumber * field2_printsign;
@property (nonatomic, retain) NSNumber * field3_dimdi;
@property (nonatomic, retain) NSString * field4_primaryKey;
@property (nonatomic, retain) NSString * field5_starKey;
@property (nonatomic, retain) NSString * field6_additionalKey;
@property (nonatomic, retain) NSString * field7_description;
@property (nonatomic, retain) NSSet *desease;
@end

@interface PossibleICDNumber (CoreDataGeneratedAccessors)

- (void)addDeseaseObject:(Desease *)value;
- (void)removeDeseaseObject:(Desease *)value;
- (void)addDesease:(NSSet *)values;
- (void)removeDesease:(NSSet *)values;

@end
