//
//  SUPDatabaseManagerFactory.h
//  supdb
//
//  Created by Scott Kovatch on 7/18/11.
//  Copyright 2011 Sybase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPDatabaseManager.h"
#import "sybase_sup.h"

extern NSString * const SUPDatabaseManager_UltraLite;
extern NSString * const SUPDatabaseManager_SQLite;

@interface SUPDatabaseManagerFactory : NSObject

+ (NSObject<SUPDatabaseManager> *)dbManagerOfType:(NSString *)type;
+ (SUPBigBinary*)createBigBinary;
+ (SUPBigString*)createBigString;
@end
