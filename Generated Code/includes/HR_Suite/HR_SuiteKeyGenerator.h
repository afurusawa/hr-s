#import "sybase_sup.h"
#import "SUPKeyGenerator.h"
#import "SUPKeyGeneratorPK.h"
#import "SUPClassWithMetaData.h"

@class SUPEntityMetaDataRBS;
@protocol SUPClassWithMetaData;
@class SUPEntityDelegate;
@class SUPClassMetaDataRBS;
@class HR_SuiteKeyGeneratorPK;

// public interface declaration, can be used by application.
/*!
 @class HR_SuiteKeyGenerator
 @abstract This class is part of package "HR_Suite:1.0"
 @discussion Generated by Sybase Unwired Platform, compiler version 2.1.3.231
*/

@interface HR_SuiteKeyGenerator : SUPKeyGenerator<SUPClassWithMetaData>
{
}
+ (SUPEntityDelegate *)delegate;
+ (SUPEntityMetaDataRBS*)metaData;
/*!
  @method 
  @abstract Creates a new autoreleased instance of this class
  @discussion
 */
+ (HR_SuiteKeyGenerator*)getInstance;
- (SUPClassMetaDataRBS*)getClassMetaData;
+ (int64_t) generateId;


@end