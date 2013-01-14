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
#define FROM_IMPORT_THREAD   TRUE
#define FROM_APP_THREAD      FALSE
#define SUP_UL_MAX_CACHE_SIZE 10485760

@class SUPBooleanUtil;
@class SUPNumberUtil;
@class SUPStringList;
@class SUPStringUtil;
@class SUPPersistenceException;
@class SUPLoginCertificate;
@class SUPLoginCredentials;
@class SUPConnectionProfile;

/*!
 @class SUPConnectionProfile
 @abstract   This class contains fields and methods needed to connect and authenticate to an SUP server.
 @discussion 
 */
@interface SUPConnectionProfile : NSObject
{
    SUPConnectionProfile* _syncProfile;
    SUPBoolean _threadLocal;
    SUPString _wrapperData;    
    NSMutableDictionary* _delegate;
    SUPLoginCertificate* _certificate;
    SUPLoginCredentials* _credentials;
    int32_t _maxDbConnections;
    BOOL      initTraceCalled;
}

/*!
    @method     
    @abstract   Return a new instance of SUPConnectionProfile.
    @discussion 
    @result The SUPconnectionprofile object.
*/

+ (SUPConnectionProfile*)getInstance;

/*!
 @method     
 @abstract   Return a new instance of SUPConnectionProfile.
 @discussion This method is deprecated. use getInstance instead.
 @result The SUPconnectionprofile object.
 */

+ (SUPConnectionProfile*)newInstance DEPRECATED_ATTRIBUTE NS_RETURNS_NON_RETAINED;
- (SUPConnectionProfile*)init;

/*!
 @property     
 @abstract   The sync profile.
 @discussion 
 */
@property(readwrite, retain, nonatomic) SUPConnectionProfile* syncProfile;

/*!
 @property
 @abstract The maximum number of active DB connections allowed
 @discussion Default value is 4, but can be changed by application developer.
 */
@property(readwrite, assign, nonatomic) int32_t maxDbConnections;

/*!
    @method     
    @abstract   The SUPConnectionProfile manages an internal dictionary of key value pairs. This method returns the SUPString value for a given string.
    @discussion 
    @param name The string.
*/
- (SUPString)getString:(SUPString)name;

/*!
 @method     
 @abstract   The SUPConnectionProfile manages an internal dictionary of key value pairs. This method returns the SUPString value for a given string.
 If the value is not found, returns 'defaultValue'.
 @discussion 
 @param name The string.
 @param defaultValue The default Value.
 */
- (SUPString)getStringWithDefault:(SUPString)name:(SUPString)defaultValue;

/*!
 @method     
 @abstract   The SUPConnectionProfile manages an internal dictionary of key value pairs. This method returns the SUPBoolean value for a given string.
 @discussion 
 @param name The string.
 */
- (SUPBoolean)getBoolean:(SUPString)name;

/*!
 @method     
 @abstract   The SUPConnectionProfile manages an internal dictionary of key value pairs. This method returns the SUPBoolean value for a given string.
 If the value is not found, returns 'defaultValue'.
 @discussion 
 @param name The string.
 @param defaultValue The default Value.
 */
- (SUPBoolean)getBooleanWithDefault:(SUPString)name:(SUPBoolean)defaultValue;

/*!
 @method     
 @abstract   The SUPConnectionProfile manages an internal dictionary of key value pairs. This method returns the SUPInt value for a given string.
 @discussion 
 @param name The string.
 */
- (SUPInt)getInt:(SUPString)name;


/*!
 @method     
 @abstract   The SUPConnectionProfile manages an internal dictionary of key value pairs. This method returns the SUPInt value for a given string.
 If the value is not found, returns 'defaultValue'.
 @discussion 
 @param name The string.
 @param defaultValue The default Value.
 */
- (SUPInt)getIntWithDefault:(SUPString)name:(SUPInt)defaultValue;
/*!
    @method   getUPA
    @abstract   retrieve upa from profile
    @discussion if it is in profile's dictionary, it returns value for key "upa";
                if it is not found in profile, it composes the upa value from base64 encoding of username:password;
                and also inserts it into profile's dictionary.
    @param      none
    @result     return string value of upa.
*/

- (SUPString)getUPA;

/*!
    @method     
    @abstract   Sets the SUPString 'value' for the given 'name'.
    @discussion 
    @param name The name.
    @param value The value.
*/
- (void)setString:(SUPString)name:(SUPString)value;

/*!
 @method     
 @abstract   Sets the SUPBoolean 'value' for the given 'name'.
 @discussion 
 @param name The name.
 @param value The value.
 */
- (void)setBoolean:(SUPString)name:(SUPBoolean)value;

/*!
 @method     
 @abstract   Sets the SUPInt 'value' for the given 'name'.
 @discussion 
 @param name The name.
 @param value The value.
 */
- (void)setInt:(SUPString)name:(SUPInt)value;

/*!
    @method     
    @abstract   Sets the username.
    @discussion 
    @param value The value.
*/
- (void)setUser:(SUPString)value;

/*!
 @method     
 @abstract   Sets the password.
 @discussion 
 @param value The value.
 */
- (void)setPassword:(SUPString)value;

/*!
 @method     
 @abstract   Sets the ClientId.
 @discussion 
 @param value The value.
 */
- (void)setClientId:(SUPString)value;

/*!
 @method     
 @abstract   Returns the databasename.
 @discussion 
 @param value The value.
 */
- (SUPString)databaseName;

/*!
 @method     
 @abstract   Sets the databasename.
 @discussion 
 @param value The value.
 */
- (void)setDatabaseName:(SUPString)value;
@property(readwrite,copy, nonatomic) SUPString databaseName;

/*!
 @method     
 @abstract   Gets the encryption key.
 @discussion 
 @result The encryption key.
 */
- (SUPString)getEncryptionKey;

/*!
 @method     
 @abstract   Sets the encryption key.
 @discussion 
 @param value The value.
 */
- (void)setEncryptionKey:(SUPString)value;

@property(readwrite,copy, nonatomic) SUPString encryptionKey;


/*!
 @property
 @abstract The authentication credentials (username/password or certificate) for this profile.
 @discussion
 */
@property(retain,readwrite,nonatomic) SUPLoginCredentials *credentials;
/*!
 @property     
 @abstract   The authentication certificate.
 @discussion If this is not null, certificate will be used for authentication.  If this is null, credentials property (username/password) will be used.
 */
@property(readwrite,retain,nonatomic) SUPLoginCertificate *certificate;
@property(readwrite, assign, nonatomic) BOOL initTraceCalled;

/*!
 @method     
 @abstract   Gets the UltraLite collation creation parameter
 @discussion 
 @result conllation string
 */
- (SUPString)getCollation;

/*!
 @method     
 @abstract   Sets the UltraLite collation creation parameter
 @discussion 
 * <p>
 * The following table lists the UltraLite supported collations:
 * <table border=0>
 * <tr>
 * <th>Collation label</th>
 * <th>Description</th>
 * </tr>
 * <tr>
 * <td>1250LATIN2</td>
 * <td>Code Page 1250, Windows Latin 2, Central/Eastern European</td>
 * </tr>
 * <tr>
 * <td>1250POL</td>
 * <td>Code Page 1250, Windows Latin 2, Polish</td>
 * </tr>
 * <tr>
 * <td>1251CYR</td>
 * <td>Code Page 1251, Windows Cyrillic</td>
 * </tr>
 * <tr>
 * <td>1252LATIN1</td>
 * <td>Code Page 1252, Windows Latin 1, Western</td>
 * </tr>
 * <tr>
 * <td>1252NOR</td>
 * <td>Code Page 1252, Windows Latin 1, Norwegian</td>
 * </tr>
 * <tr>
 * <td>1252SPA</td>
 * <td>Code Page 1252, Windows Latin 1, Spanish</td>
 * </tr>
 * <tr>
 * <td>1252SWEFIN</td>
 * <td>Code Page 1252, Windows Latin 1, Swedish/Finnish</td>
 * </tr>
 * <tr>
 * <td>1253ELL</td>
 * <td>Code Page 1253, Windows Greek, ISO8859-7 with extensions</td>
 * </tr>
 * <tr>
 * <td>1254TRK</td>
 * <td>Code Page 1254, Windows Turkish, ISO8859-9 with extensions</td>
 * </tr>
 * <tr>
 * <td>1254TRKALT</td>
 * <td>Code Page 1254, Windows Turkish, ISO8859-9 with extensions, I-dot e als I-no-dot</td>
 * </tr>
 * <tr>
 * <td>1255HEB</td>
 * <td>Code Page 1255, Windows Hebrew, ISO8859-8 with extensions</td>
 * </tr>
 * <tr>
 * <td>1256ARA</td>
 * <td>Code Page 1256, Windows Arabic, ISO8859-6 with extensions</td>
 * </tr>
 * <tr>
 * <td>1257LIT</td>
 * <td>Code Page 1257, Windows Baltic Rim, Lithuanian</td>
 * </tr>
 * <tr>
 * <td>874THAIBIN</td>
 * <td>Code Page 874, Windows Thai, ISO8859-11, binary ordering</td>
 * </tr>
 * <tr>
 * <td>932JPN</td>
 * <td>Code Page 932, Japanese Shift-JIS with Microsoft extensions</td>
 * </tr>
 * <tr>
 * <td>936ZHO</td>
 * <td>Code Page 936, Simplified Chinese, PRC GBK</td>
 * </tr>
 * <tr>
 * <td>949KOR</td>
 * <td>Code Page 949, Korean KS C 5601-1987 Encoding, Wansung</td>
 * </tr>
 * <tr>
 * <td>950ZHO_HK</td>
 * <td>Code Page 950, Traditional Chinese, Big 5 Encoding with HKSCS</td>
 * </tr>
 * <tr>
 * <td>950ZHO_TW</td>
 * <td>Code Page 950, Traditional Chinese, Big 5 Encoding</td>
 * </tr>
 * <tr>
 * <td>EUC_CHINA</td>
 * <td>Simplified Chinese, GB 2312-80 Encoding</td>
 * </tr>
 * <tr>
 * <td>EUC_JAPAN</td>
 * <td>Japanese EUC JIS X 0208-1990 and JIS X 0212-1990 Encoding</td>
 * </tr>
 * <tr>
 * <td>EUC_KOREA</td>
 * <td>Code Page 1361, Korean KS C 5601-1992 8-bit Encoding, Johab</td>
 * </tr>
 * <tr>
 * <td>EUC_TAIWAN</td>
 * <td>Code Page 964, EUC-TW Encoding</td>
 * </tr>
 * <tr>
 * <td>ISO1LATIN1</td>
 * <td>ISO8859-1, ISO Latin 1, Western, Latin 1 Ordering</td>
 * </tr>
 * <tr>
 * <td>ISO9LATIN1</td>
 * <td>ISO8859-15, ISO Latin 9, Western, Latin 1 Ordering</td>
 * </tr>
 * <tr>
 * <td>ISO_1</td>
 * <td>ISO8859-1, ISO Latin 1, Western</td>
 * </tr>
 * <tr>
 * <td>ISO_BINENG</td>
 * <td>Binary ordering, English ISO/ASCII 7-bit letter case mappings</td>
 * </tr>
 * <tr>
 * <td>UTF8BIN</td>
 * <td>UTF-8, 8-bit multibyte encoding for Unicode, binary ordering</td>
 * </tr>
 * </table>
 @param value The value.
 */
- (void)setCollation:(SUPString)value;

@property(readwrite,copy, nonatomic) SUPString collation;

/*!
 @method     
 @abstract   Gets the maximum cache size in bytes; the default value for iOS is 10485760 (10 MB).
 @discussion 
 @result max cache size
 */
- (int)getCacheSize;
/*!
 @method     
 @abstract   Sets the maximum cache size in bytes.
 @discussion For Ultralite, passes the cache_max_size property into the connection parameters for DB connections; For SQLite, executes the "PRAGMA cache_size" statement when a connection is opened.
 @param cacheSize value
 */
- (void)setCacheSize:(int)cacheSize;
    
@property(readwrite,assign, nonatomic) int cacheSize;
/*!
    @method     
    @abstract   Returns the user.
    @discussion 
    @result The username.
*/
- (SUPString)getUser;
/*!
 @method     
 @abstract   Returns the password hash value.
 @discussion 
 @result The password hash value.
 */

- (NSUInteger)getPasswordHash;
/*!
 @method     
 @abstract   Returns the password.
 @discussion 
 @result The password hash value.
 */

- (NSString*)getPassword;

/*!
 @method     
 @abstract   Adds a new key value pair.
 @discussion 
 @param key The key.
 @param value The value.
 */
- (void)add:(SUPString)key:(SUPString)value;

/*!
    @method     
    @abstract   Removes the key.
    @discussion 
    @param key The key to remove.
*/

- (void)remove:(SUPString)key;
- (void)clear;

/*!
 @method     
 @abstract   Returns a boolean indicating if the key is present.
 @discussion 
 @param key The key.
 @result The result indicating if the key is present.
 */
- (SUPBoolean)containsKey:(SUPString)key;

/*!
 @method     
 @abstract   Returns the item for the given key.
 @discussion 
 @param key  The key.
 @result The item.
 */
- (SUPString)item:(SUPString)key;

/*!
 @method     
 @abstract   Returns the list of keys.
 @discussion 
 @result The keylist.
 */
- (SUPStringList*)keys;

/*!
 @method     
 @abstract   Returns the list of values.
 @discussion 
 @result The value list.
 */
- (SUPStringList*)values;

/*!
 @method     
 @abstract   Returns the internal map of key value pairs.
 @discussion 
 @result The NSMutableDictionary with key value pairs.
 */
- (NSMutableDictionary*)internalMap;
/*!
 @method     
 @abstract   Returns the domain name.
 @result The domain name.
 @discussion
*/
- (SUPString)getDomainName;

/*!
 @method     
 @abstract   Sets the domain name.
 @param value The domain name.
 @discussion 
 */
- (void)setDomainName:(SUPString)value;

/*!
 @method     
 @abstract   Get async operation replay property. Default is true.
 @result YES : if ansync operation replay is enabled; NO: if async operation is disabled.
 @discussion  
 */
- (BOOL) getAsyncReplay;

/*!
 @method     
 @abstract   Set async operation replay property. Default is true.
 @result value: enable/disable async replay operation.
 @discussion  
 */

- (void) setAsyncReplay:(BOOL) value;

/*!
 @method     
 @abstract   enable or disable the trace in client object API.
 @param enable - YES: enable the trace; NO: disable the trace.
 @discussion 
 */
- (void)enableTrace:(BOOL)enable;

/*!
 @method     
 @abstract   enable or disable the trace with payload info in client object API.
 @param enable - YES: enable the trace; NO: disable the trace.
 @param withPayload = YES: show payload information; NO: not show payload information.
 @discussion 
 */
- (void)enableTrace:(BOOL)enable withPayload:(BOOL)withPayload;

/*!
 @method     
 @abstract   initialize trace levels from server configuration.
 @discussion 
 */

- (void)initTrace;

- (void)dealloc;

/* ultralite/mobilink required parameters */
- (SUPString)getNetworkProtocol;
- (void)setNetworkProtocol:(SUPString)protocol;
- (SUPString)getNetworkStreamParams;
- (void)setNetworkStreamParams:(SUPString)stream;
- (SUPString)getServerName;
- (void)setServerName:(SUPString)name;
- (int)getPortNumber;
- (void)setPortNumber:(int)port;
- (int)getPageSize;
- (void)setPageSize:(int)size;

@end

@interface SUPConnectionProfile(internal)

- (void)applyPropertiesFromApplication;


@end
