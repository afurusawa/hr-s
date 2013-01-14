//
//  SUPClientPersonalizationDelegate.h
//  clientrt
//
//  Created by Jane Yang on 11/9/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SUPObjectList;
@class SUPDatabaseDelegate;

@interface SUPClientPersonalizationDelegate : NSObject
{
    @protected
    NSString * tableName;
    SUPDatabaseDelegate *dbDelegate;
}
@property(readwrite, retain, nonatomic) NSString *tableName;
@property(readwrite, retain, nonatomic) SUPDatabaseDelegate *dbDelegate;

- (SUPClientPersonalizationDelegate*)initWithDbDelegate:(SUPDatabaseDelegate*)dbd;
- (SUPObjectList*)findByUser:(NSString*)user;
- (SUPObjectList*)findAll;
- (SUPObjectList*)findByUser:(NSString *)user withSkip:(int)skip withTake:(int)take;
- (void)dealloc;
@end
