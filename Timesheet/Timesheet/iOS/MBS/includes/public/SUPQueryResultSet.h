/*
 
 Copyright (c) Sybase, Inc. 2010   All rights reserved.                                    
 
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



#import "sybase_sup.h"

@class SUPObjectList;
@class SUPStringList;
@class SUPStringUtil;
@class SUPDataType;
@class SUPDataValue;
@class SUPDataValueList;
//@protocol DatabaseMetaData;
//@protocol EntityMetaData;
@class SUPPersistenceException;
@class SUPQuery;
@class SUPSelectItem;
//@class RbsSUPStatementBuilder;

@protocol SUPResultSetWrapper;
@protocol SUPStatementWrapper;

#import "SUPArrayList.h"

@class SUPQueryResultSet;


/*!
 @class SUPQueryResultSet
 @abstract   An SUPQueryResultSet object represents the result set from a dynamic query.
 @discussion  This type of object is returned by a package's database class method executeQuery:, and by MBO named query methods that return
 result sets instead of MBO lists.  An SUPQueryResultSet contains attributes representing the names and types of the columns selected in the query
 that produced the result set.
 
 Example code showing a query that executes and returns a result set, and then code to go through the result set and print the rows returned.
 
 <pre>
 SUPQuery *query = [SUPQuery getInstance];
 [query select:@"c.fname,c.lname,s.order_date,s.region"];        
 [query  from:@"Customer":@"c"];
 [query  join:@"SalesOrder":@"s":@"s.cust_id":@"c.id"];
 query.testCriteria = [SUPAttributeTest match:@"c.lname":@"Devlin"];
 SUPQueryResultSet* resultSet = [SampleApp_SampleAppDB executeQuery:query];
 if(resultSet == nil)
 {
 MBOLog(@"executeQuery Failed !!");
 return;
 }
 for(SUPDataValueList* result in resultSet)
 {
 MBOLog(@"Firstname,lastname,order date,region = %@ %@ %@ %@",
 [SUPDataValue  getNullableString:[result item:0]],
 [SUPDataValue getNullableString:[result item:1]],
 [[SUPDataValue getNullableDate:[result item:2]] description],
 [SUPDataValue getNullableString:[result item:3]]);
 }
</pre> 
 
 See also:
 @link //apple_ref/occ/cl/SUPQueryResultSet SUPQueryResultSet @/link
 @link //apple_ref/occ/cl/SUPDataValue SUPDataValue @/link 
 @link //apple_ref/occ/cl/SUPDataValueList SUPDataValueList @/link

 */

@interface SUPQueryResultSet : SUPArrayList
{
    SUPStringList* _columnNames;
    SUPObjectList* _columnTypes;
    
 //   @private
        id<SUPStatementWrapper> _sw;
        id<SUPResultSetWrapper> _rs;
        int             _current_pos;
        SUPBoolean      _connectedRSMode;
}

/*!
 @property     
 @abstract   Returns the columnnames.
 @discussion 
*/
@property(readwrite, retain, nonatomic) SUPStringList* columnNames;

/*!
 @property 
 @abstract  Returns the columnTypes.
 @discussion 
 */
@property(readwrite, retain, nonatomic) SUPObjectList* columnTypes;

@property(readwrite, retain, nonatomic) id<SUPStatementWrapper> sw;
@property(readwrite, retain, nonatomic) id<SUPResultSetWrapper> rs;
@property(readwrite, assign, nonatomic) int current_pos;
@property(readwrite, assign, nonatomic) SUPBoolean connectedRSMode;

/*!
 @method     
 @abstract   Returns a new instance of SUPQueryResultSet.
 @result The SUPQueryResultSet.
 @discussion 
 */

+ (SUPQueryResultSet*)getInstance;

/*!
 @method     
 @abstract   (Deprecated) Returns a new instance of SUPQueryResultSet.
 @result The SUPQueryResultSet.
 @discussion This method is deprecated. use getInstance.
 */

+ (SUPQueryResultSet*)newInstance DEPRECATED_ATTRIBUTE NS_RETURNS_NON_RETAINED;

/*!
 @method     
 @abstract   set connected database result set and statement wrapper
 @param rs - object pointer to SUPResultSetWrapper.
 @param sw - object pointer to SUPStatementWrapper.
 @discussion 
 */
 
- (void)setCursor: (id<SUPResultSetWrapper>)rs :(id<SUPStatementWrapper>)sw;

/*!
 @method     
 @abstract   Returns a new instance of SUPQueryResultSet initialized to "capacity".
 @param cpacity The capacity.
 @result The SUPQueryResultSet.
 @discussion 
 */
+ (SUPQueryResultSet*)listWithCapacity:(SUPInt)capacity;

/*!
 @method     
 @abstract   Add an item to the SUPQueryResultSet.
 @param item The item to add.
 @discussion 
 */
- (void)add:(SUPDataValueList*)item;

/*!
 @method     
 @abstract   Returnns item at "index".
 @param index The index.
 @result The SUPDataValueList.
 @discussion 
 */
- (SUPDataValueList*)item:(SUPInt)index;

/*!
 @method     
 @abstract   Clears the SUPQueryResultSet.
 @discussion 
 */
- (void)clear;
- (void)dealloc;

/*!
 @method     
 @abstract   retrieve column type at "index".
 @param index - The index.
 @result The SUPDataType*.
 @discussion 
 */

- (SUPDataType*)getColumnType: (int) index;

/*!
 @method     
 @abstract   retrieve column name at "index".
 @param index - The index.
 @result The SUPString.
 @discussion 
 */

- (SUPString)getColumnName: (int) index;

/*!
 @method     
 @abstract   retrieve number of columns in the result set.
 @discussion 
 @result number of columns.
 */

- (int)getColumnCount;
/*!
    @method     
    @abstract   Move to first row in result set. It is not supported for the connectecd result set mode.        
    @discussion 
    @result True on success, otherwise false.
*/
- (BOOL)first;

/*!
    @method     
    @abstract   Move to last row in result set. It is not supported for the connectecd result set mode.          
    @discussion 
    @result True on success,otherwise false.
*/
- (BOOL)last;

/*!
    @method     
    @abstract   Move to next row in result set.            
    @discussion 
    @result True if there are still more rows in the result set, false if the end has been reached.
*/
- (BOOL)next;

/*!
    @method     
    @abstract   move the cursor by offset rows from the current cursor position. It is not supported for the connectecd result set mode.      
    @discussion 
    @param offset - offset from current cursor position.
    @result true on success, otherwise false.
*/
- (BOOL)relative:(SUPInt)offset;

/*!
    @method     
    @abstract   move the cursor to the specified position. It is not supported for the connectecd result set mode.         
    @discussion 
    @result true on success, otherwise false.
*/
- (BOOL)absolute:(SUPInt)index;

/*!
    @method     
    @abstract   Move to before first row in result set. It is not supported for the connectecd result set mode.           
    @discussion 
    @result True on success, otherwise false.
*/
- (BOOL)beforeFirst;

/*!
    @method     
    @abstract   Move to after last row in result set.  It is not supported for the connectecd result set mode.          
    @discussion 
    @result True on success, otherwise false.
*/
- (BOOL)afterLast;

/*!
    @method     
    @abstract   Move to previous row in result set.  It is not supported for the connectecd result set mode.          
    @discussion 
    @result True on success, otherwise false.
*/
- (BOOL)previous;

/*!
    @method     
    @abstract   close the resultset connection and database statement wrapper connection in the connected result set mode;
                remove all the cached objects in the disconnected result set mode;
    @discussion 
*/
- (void)close;

/*!
    @method     
    @abstract   get row count in the result set. it is 0 in the connected result set mode.           
    @discussion 
    @result row count.
*/
- (int)getRowCount;

/*!
    @method     
    @abstract   get current row index.           
    @discussion 
    @result current row index.
*/
- (int)getRow;

/*!
 @method     
 @abstract   Retrieve binary type data with given index from the result set.
 @discussion 
 @param index - 1-based index in sql query list.
 @result SUPBinary type of not null data.
 */
- (SUPBinary)getBinary:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve binary type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPBinary type of not null data.
 */
- (SUPBinary)getBinary:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve int type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPInt type of not null data.
 */
- (SUPInt) getInt:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve int type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPInt type of not null data.
 */
- (SUPInt)getInt:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve double type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPDouble type of not null data.
 */
- (SUPDouble) getDouble:(SUPInt)index;
/*!
 @method     
 @abstract   Retrieve double type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPDouble type of not null data.
 */
- (SUPDouble)getDouble:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve float type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPFloat type of not null data.
 */
- (SUPFloat) getFloat:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve float type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPFloat type of not null data.
 */
- (SUPFloat)getFloat:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve string type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPString type of not null data.
 */
- (SUPString) getString:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve string type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPString type of not null data.
 */
- (SUPString)getString:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve datetime type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPDateTime type of not null data.
 */
- (SUPDateTime) getDateTime:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve datetime type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPDateTime type of not null data.
 */
- (SUPDateTime)getDateTime:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve date type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPDate type of not null data.
 */
- (SUPDate) getDate:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve date type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPDate type of not null data.
 */
- (SUPDate)getDate:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve time type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPTime type of not null data.
 */
- (SUPTime) getTime:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve time type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPTime type of not null data.
 */
- (SUPTime)getTime:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve byte type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPByte type of not null data.
 */
- (SUPByte) getByte:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve byte type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPByte type of not null data.
 */
- (SUPByte)getByte:(SUPInt)index withName:(SUPString)name;

/*!
    @method     
    @abstract   Retrieve boolean type data with given index from the result set.
    @discussion 
    @param index - index in sql query list.
    @result SUPBoolean type of not null data.
*/
- (SUPBoolean) getBoolean:(SUPInt)index;

/*!
    @method     
    @abstract   Retrieve boolean type data with given index and given name from the result set.
    @discussion 
    @param index - index in sql query list.
    @param name - name of the column.
    @result SUPBoolean type of not null data.
*/
- (SUPBoolean)getBoolean:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve short type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPShort type of not null data.
 */
- (SUPShort) getShort:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve short type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPShort type of not null data.
 */
- (SUPShort)getShort:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve long type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPLong type of not null data.
 */
- (SUPLong) getLong:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve long type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPLong type of not null data.
 */
- (SUPLong)getLong:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrievechar type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPChar type of not null data.
 */
- (SUPChar) getChar:(SUPInt)index;

/*!
 @method     
 @abstract   Retrievechar type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPChar type of not null data.
 */
- (SUPChar)getChar:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve decimal type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPDecimal type of not null data.
 */
- (SUPDecimal) getDecimal:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve decimal type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPDecimal type of not null data.
 */
- (SUPDecimal)getDecimal:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve Integer type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPInteger type of not null data.
 */
- (SUPInteger) getInteger:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve Integer type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPInteger type of not null data.
 */
- (SUPInteger)getInteger:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   check if the value for the column is null or not
 @discussion 
 @param index - index in sql query list.
 @result true if the column is null, otherwise false.
 */
- (BOOL)isNull:(SUPInt)index;

/*!
 @method     
 @abstract   check if the value for the column is null or not
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result true if the column is null, otherwise false.
 */
- (BOOL)isNull:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve binary type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableBinary type of nullable data.
 */
- (SUPNullableBinary)getNullableBinary:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve binary type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - column name.
 @result SUPNullableBinary type of nullable data.
 */
- (SUPNullableBinary)getNullableBinary:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve int type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableInt type of nullable data.
 */
- (SUPNullableInt)getNullableInt:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve int type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableInt type of nullable data.
 */
- (SUPNullableInt)getNullableInt:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve double type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableDouble type of nullable data.
 */
- (SUPNullableDouble)getNullableDouble:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve double type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableDouble type of nullable data.
 */
- (SUPNullableDouble)getNullableDouble:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve float type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableFloat type of nullable data.
 */
- (SUPNullableFloat)getNullableFloat:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve float type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableFloat type of nullable data.
 */
- (SUPNullableFloat)getNullableFloat:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract    Retrieve string type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableString type of nullable data.
 */
- (SUPNullableString)getNullableString:(SUPInt)index;

/*!
 @method     
 @abstract    Retrieve string type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableString type of nullable data.
 */
- (SUPNullableString)getNullableString:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve datetime type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableDateTime type of nullable data.
 */
- (SUPNullableDateTime) getNullableDateTime:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve datetime type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableDateTime type of nullable data.
 */
- (SUPNullableDateTime)getNullableDateTime:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve date type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableDate type of nullable data.
 */
- (SUPNullableDate) getNullableDate:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve date type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableDate type of nullable data.
 */
- (SUPNullableDate)getNullableDate:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve time type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableTime type of nullable data.
 */
- (SUPNullableTime) getNullableTime:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve time type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableTime type of nullable data.
 */

- (SUPNullableTime)getNullableTime:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve byte type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableByte type of nullable data.
 */
- (SUPNullableByte) getNullableByte:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve byte type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableByte type of nullable data.
 */
- (SUPNullableByte)getNullableByte:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract  Retrieve boolean type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableBoolean type of nullable data.
 */
- (SUPNullableBoolean) getNullableBoolean:(SUPInt)index;

/*!
 @method     
 @abstract  Retrieve boolean type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableBoolean type of nullable data.
 */
- (SUPNullableBoolean)getNullableBoolean:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve short type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableShort type of nullable data.
 */
- (SUPNullableShort) getNullableShort:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve short type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableShort type of nullable data.
 */
- (SUPNullableShort)getNullableShort:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve long type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableLong type of nullable data.
 */
- (SUPNullableLong) getNullableLong:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve long type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableLong type of nullable data.
 */
- (SUPNullableLong)getNullableLong:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve char type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableChar type of nullable data.
 */
- (SUPNullableChar) getNullableChar:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve char type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableChar type of nullable data.
 */
- (SUPNullableChar)getNullableChar:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve decimal type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableDecimal type of nullable data.
 */
- (SUPNullableDecimal) getNullableDecimal:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve decimal type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableDecimal type of nullable data.
 */
- (SUPNullableDecimal)getNullableDecimal:(SUPInt)index withName:(SUPString)name;

/*!
 @method     
 @abstract   Retrieve integer type data with given index from the result set.
 @discussion 
 @param index - index in sql query list.
 @result SUPNullableInteger type of nullable data.
 */
- (SUPNullableInteger) getNullableInteger:(SUPInt)index;

/*!
 @method     
 @abstract   Retrieve integer type data with given index and given name from the result set.
 @discussion 
 @param index - index in sql query list.
 @param name - name of the column.
 @result SUPNullableInteger type of nullable data.
 */
- (SUPNullableInteger)getNullableInteger:(SUPInt)index withName:(SUPString)name;
@end

@interface SUPQueryResultSet(internal)
- (void)populate:(id<SUPResultSetWrapper>)rs;
@end
