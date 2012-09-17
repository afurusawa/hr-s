/*
 
 Copyright (c) Sybase, Inc. 2012   All rights reserved.                                    
 
 In addition to the license terms set out in the Sybase License Agreement for 
 the Sybase Unwired Platform ("Program"), the following additional or different 
 rights and accompanying obligations and restrictions shall apply to the source 
 code in this file ("Code").  Sybase grants you a limited, non-exclusive, 
 non-transferable, revocable license to use, reproduce, and modify the Code 
 solely for purposes of (i) maintaining the Code as reference material to better
 understand the operation of the Program, and (ii) development and testing of 
 applications created in connection with your licensed use of the Program.  
 The Code may not be transferred, sold, assigned, sublicensed or otherwise 
 conveyed (whether by operation of law or otherwise) to another party without 
 Sybase's prior written consent.  The following provisions shall apply to any 
 modifications you make to the Code: (i) Sybase will not provide any maintenance
 or support for modified Code or problems that result from use of modified Code;
 (ii) Sybase expressly disclaims any warranties and conditions, express or 
 implied, relating to modified Code or any problems that result from use of the 
 modified Code; (iii) SYBASE SHALL NOT BE LIABLE FOR ANY LOSS OR DAMAGE RELATING
 TO MODIFICATIONS MADE TO THE CODE OR FOR ANY DAMAGES RESULTING FROM USE OF THE 
 MODIFIED CODE, INCLUDING, WITHOUT LIMITATION, ANY INACCURACY OF DATA, LOSS OF 
 PROFITS OR DIRECT, INDIRECT, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES, EVEN
 IF SYBASE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; (iv) you agree 
 to indemnify, hold harmless, and defend Sybase from and against any claims or 
 lawsuits, including attorney's fees, that arise from or are related to the 
 modified Code or from use of the modified Code. 
 
 */



#import <Foundation/Foundation.h>
#import "sybase_sup.h"
#import "SUPDatabaseDelegate.h"
#import "SUPKeyGeneratorPK.h"

/*
@class SUPDatabaseDelegate;
@class SUPKeyGeneratorPK;
@protocol SUPCallbackHandler;
@class SUPJsonArray;
@class SUPJsonObject;
@class SUPObjectList;
*/
@interface SUPKeyGenerator : NSObject
{
    
}
@property(readwrite, assign, nonatomic) SUPLong firstId;
@property(readwrite, assign, nonatomic) SUPLong lastId;
@property(readwrite, assign, nonatomic) SUPLong nextId;
@property(readwrite, assign, nonatomic) SUPLong batchId;
@property(readwrite, retain, nonatomic) SUPString remoteId;
@property(readwrite, retain, nonatomic) SUPDatabaseDelegate *db_delegate;
@property(readwrite, retain, nonatomic) SUPString   table_name;
@property(readwrite, retain, nonatomic) SUPString   pkg;
@property(readwrite, assign, nonatomic) SUPLong batch_size;
@property(readwrite, assign, nonatomic) BOOL isNew;
@property(readwrite, assign, nonatomic) BOOL isDirty;
@property(readwrite, assign, nonatomic) BOOL isDeleted;
@property(readwrite, retain, nonatomic) NSObject<SUPCallbackHandler>   *callbackHandler;

- (id)initWithParameters:(SUPDatabaseDelegate*)delegate:(SUPString)table:(SUPLong)size;
- (id)init;
- (SUPKeyGeneratorPK*)pk;
- (SUPString)keyToString;
- (void)registerCallbackHandler:(NSObject<SUPCallbackHandler>*)handler;
- (void) copyAll:(SUPKeyGenerator*)entity;
- (void) refresh;
- (SUPKeyGenerator*)load:(SUPKeyGeneratorPK*)key;
- (void) save;
- (SUPKeyGenerator*) find:(SUPKeyGeneratorPK*)key;
- (void) create;
- (void) update;
- (void) delete;
- (void)dealloc;
+ (SUPJsonObject*) toJson:(SUPKeyGenerator*)obj;
- (SUPJsonObject*) toJson;
+ (SUPObjectList*) fromJSONList:(SUPJsonArray*)array;
+ (SUPJsonArray*) toJSONList:(SUPObjectList*) list;
+ (SUPKeyGenerator*) fromJson:(SUPJsonObject*)json;
- (void) fromJson:(SUPJsonObject*)json;
- (SUPLong) generateId;
- (BOOL) initSync;
+ (id) getObjectInstance:(SUPString)packageName;
+ (void) setObjectInstance :(SUPString)packageName :(id)object;
- (SUPObjectList*)findAll;
- (NSString*)getRemoteId;
@end
