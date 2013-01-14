//
//  DataSingleton.h
//  HRDirectory
//
//  Created by Alex Chiu on 9/11/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataSingleton : NSObject

@property (nonatomic, retain) NSMutableArray *hr_users;

+(DataSingleton *)instance;
-(NSDictionary *)findByUsername:(NSString *)username;

@end
