/*
Copyright (c) Sybase, Inc. 2011 All rights reserved. 

In addition to the license terms set out in the Sybase License Agreement for 
the Sybase Unwired Platform ("Program"), the following additional or different 
rights and accompanying obligations and restrictions shall apply to the source 
code in this file ("Code"). Sybase grants you a limited, non-exclusive, 
non-transferable, revocable license to use, reproduce, and modify the Code 
solely for purposes of (i) maintaining the Code as reference material to better 
understand the operation of the Program, and (ii) development and testing of 
applications created in connection with your licensed use of the Program. 
The Code may not be transferred, sold, assigned, sublicensed or otherwise 
conveyed (whether by operation of law or otherwise) to another party without 
Sybase's prior written consent. The following provisions shall apply to any 
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

//
//  DataVaultWrapper.h
//
//  C functions to wrap functionality of DataVault class
//  Used by Mobile Office App and the unit test functions

#pragma once

// Return codes from wrapper methods
// Wrapper methods catches NSException and return corresponding error
typedef enum {
   kDVWrapperSuccess = 0,
   kDVWrapperErrorLocked,
   kDVWrapperErrorInvalidPassword,
   kDVWrapperErrorInvalidArg,
   kDVWrapperErrorAlreadyExists,
   kDVWrapperErrorDoesNotExist,
   kDVWrapperErrorDataTypeError,
   kDVWrapperErrorPasswordExpired,
   kDVWrapperErrorPasswordRequired,
   kDVWrapperErrorPasswordUnderMinLength,
   kDVWrapperErrorPasswordRequiresDigit,
   kDVWrapperErrorPasswordRequiresUpper,
   kDVWrapperErrorPasswordRequiresLower,
   kDVWrapperErrorPasswordRequiresSpecial,
   kDVWrapperErrorPasswordUnderMinUniqueChars
} DataVaultWrapperStatus;

// Wrapper enum for DataTypes supported by DataVault
typedef enum {
   kDVWrapDataTypeUnknown,
   kDVWrapDataTypeString,
   kDVWrapDataTypeBinary
} DVWrapDataType;

// Attributes defining password policy used by DataVault
typedef struct
{
	bool bDefaultPasswordAllowed;
	int  iMinLength;
	bool bHasDigits;
	bool bHasUpper;
	bool bHasLower;
	bool bHasSpecial;
	int  iExpirationDays;
	int  iMinUniqueChars;
	int  iLockTimeout;
	int  iRetryLimit;
} DVWrapPasswordPolicy;


// Attributes for DataName
typedef struct
{
	char * name;
	DVWrapDataType  type;
} DVWrapDataName;

// Wrapper constant for kDVUnlimitedRetriesAllowed defined in DataVault.h
#define DV_UNLIMITED_RETRIES_ALLOWED_WRAPPER       0

// Wrapper constant for kNoIdleTimeout defined in DataVault.h
#define DV_NO_LOCK_TIMEOUT_WRAPPER                 0

// Default values for password policy attributes
#define PWDPOLICY_DEFVALUEWRAP_DEF_PWD_ALLOWED     1
#define PWDPOLICY_DEFVALUEWRAP_MIN_LENGTH          0
#define PWDPOLICY_DEFVALUEWRAP_HAS_DIGITS          0
#define PWDPOLICY_DEFVALUEWRAP_HAS_UPPER           0
#define PWDPOLICY_DEFVALUEWRAP_HAS_LOWER           0
#define PWDPOLICY_DEFVALUEWRAP_HAS_SPECIAL         0
#define PWDPOLICY_DEFVALUEWRAP_EXPIRATION_DAYS     0
#define PWDPOLICY_DEFVALUEWRAP_MIN_UNIQUE_CHARS    0
#define PWDPOLICY_DEFVALUEWRAP_LOCK_TIMEOUT        DV_NO_LOCK_TIMEOUT_WRAPPER
#define PWDPOLICY_DEFVALUEWRAP_RETRY_LIMIT         DV_UNLIMITED_RETRIES_ALLOWED_WRAPPER

DataVaultWrapperStatus DataVault_createVault( const char* pszVaultId, const char* pszPassword, const char *pszSalt );
bool DataVault_vaultExists( const char* pszVaultId );
DataVaultWrapperStatus DataVault_deleteVault( const char* pszVaultId );

DataVaultWrapperStatus DataVault_setValue( const char* pszVaultId, const char* pszDataName, unsigned char* pcData, int iDataSize );
DataVaultWrapperStatus DataVault_getValue( const char* pszVaultId, const char* pszDataName, unsigned char** ppcData, int* piDataSize );
DataVaultWrapperStatus DataVault_setStrValue( const char* pszVaultId, const char* pszDataName, const char* pszDataValue );
DataVaultWrapperStatus DataVault_getStrValue( const char* pszVaultId, const char* pszDataName, char** ppszDataValue );
DataVaultWrapperStatus DataVault_deleteValue( const char* pszVaultId, const char* pszDataName );

DataVaultWrapperStatus DataVault_unlock( const char* pszVaultId, const char* pszPassword, const char *pszSalt );
DataVaultWrapperStatus DataVault_lock( const char* pszVaultId );
bool DataVault_isLocked( const char* pszVaultId );
bool DataVault_isDefaultPasswordUsed( const char* pszVaultId );

DataVaultWrapperStatus DataVault_changePassword( const char* pszVaultId, const char* pszNewPassword, const char *pszNewSalt );
DataVaultWrapperStatus DataVault_changePassword( const char* pszVaultId, const char* pszCurPassword, const char *pszCurSalt, const char* pszNewPassword, const char *pszNewSalt );

DataVaultWrapperStatus DataVault_getLockTimeout( const char* pszVaultId, int* piLockTimeout );
DataVaultWrapperStatus DataVault_setLockTimeout( const char* pszVaultId, int iLockTimeout );
DataVaultWrapperStatus DataVault_resetLockTimeout( const char* pszVaultId );
DataVaultWrapperStatus DataVault_getRetryLimit( const char* pszVaultId, int* piRetryLimit );
DataVaultWrapperStatus DataVault_setRetryLimit( const char* pszVaultId, int iRetryLimit );

DataVaultWrapperStatus DataVault_setPasswordPolicy( const char* pszVaultId, const DVWrapPasswordPolicy* pPwdPolicy );
DataVaultWrapperStatus DataVault_getPasswordPolicy( const char* pszVaultId, DVWrapPasswordPolicy* pPwdPolicy );

DataVaultWrapperStatus DataVault_getDataNames( const char* pszVaultId, DVWrapDataName** ppDataNames, int *piDataCount );
void DataVault_freeDataNames( DVWrapDataName** ppDataNames, int iDataCount );

const char* DataVault_getMessagingDataVaultID();
const char* DataVault_getStandardPassword();
const char* DataVault_getStandardHash();
