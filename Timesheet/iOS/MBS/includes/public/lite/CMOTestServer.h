/*******************************************************************************
* Source File        : Cmotestserver.h
* Date Created       : 08/10/04 08:43:54
* Description        : Automatically generated source file containing the 
*                      Cmotestserver class interface implementation.
* MO CIE Version     : 4
******************************************************************************/

#ifndef CMOTESTSERVER_H
#define CMOTESTSERVER_H

#include "moClient.h"

class MOTestServerClass : public CmoObject
{

public:
   MOTestServerClass( CmoConnection* pConn );

   void CleanLogs( CmoRequestOptions* RequestOptions );


   void LogTestStart( long lTestId, 
                      CmoRequestOptions* RequestOptions );


   void LogTestEnd( long lTestId, 
                    CmoRequestOptions* RequestOptions );


   void LogFailure( long lTestId, 
                    CmoString* sFilename, 
                    long lLine, 
                    long lErrorCode, 
                    CmoString* sErrorMsg, 
                    CmoRequestOptions* RequestOptions );


   bool CheckRecordSet( CmoRecordset* MungedRS, 
                        CmoRecordset* ControlRS, 
                        CmoRequestOptions* RequestOptions );


   void MasterLog( CmoString* strTestSuite, 
                   CmoString* strTestName, 
                   short iTestNum, 
                   CmoString* strPlatform, 
                   bool bPassed, 
                   CmoString* strBuild, 
                   CmoString* StrErrorMessage, 
                   CmoRequestOptions* RequestOptions );


   void UpdateObject( CmoString* strAdminUserName, 
                      CmoString* strAdminPwd, 
                      short Version, 
                      CmoString* strErr, 
                      CmoRequestOptions* RequestOptions );


   long GetTimesCalled( long SleepVal, 
                        CmoRequestOptions* RequestOptions );


   long PassRecordset( CmoRecordset* rs, 
                       CmoString* Command, 
                       CmoRequestOptions* RequestOptions );


   long CloneRecordset( CmoRecordset* rs, 
                        CmoRequestOptions* RequestOptions );


   long CopyRecordset( CmoRecordset* rs, 
                       CmoRecordset* SourceRS, 
                       CmoRequestOptions* RequestOptions );


   CmoRecordset* GetRecordset( CmoRequestOptions* RequestOptions );


   long GetLogRS( CmoRecordset* rs, 
                  CmoRequestOptions* RequestOptions );


   void ThrowException( CmoRequestOptions* RequestOptions );


   void SendLargePacket( CmoString* sString1, 
                         long l, 
                         CmoString* sString2, 
                         long l2, 
                         CmoRequestOptions* RequestOptions );


   CmoString* ReturnString( CmoString* s, 
                            CmoRequestOptions* RequestOptions );


   CmoString* ReturnEmptyString( CmoString* s, 
                                 CmoRequestOptions* RequestOptions );


   CmoString* ReturnNullString( CmoString* s, 
                                CmoRequestOptions* RequestOptions );


   bool ReturnBoolean( bool b, 
                       CmoRequestOptions* RequestOptions );


   bool ReturnNullBoolean( bool b, 
                           CmoRequestOptions* RequestOptions );


   float ReturnSingle( float f, 
                       CmoRequestOptions* RequestOptions );


   float ReturnNullSingle( float f, 
                           CmoRequestOptions* RequestOptions );


   double ReturnDouble( double d, 
                        CmoRequestOptions* RequestOptions );


   double ReturnNullDouble( double d, 
                            CmoRequestOptions* RequestOptions );


   long ReturnLong( long l, 
                    CmoRequestOptions* RequestOptions );


   long ReturnNullLong( long l, 
                        CmoRequestOptions* RequestOptions );


   short ReturnInt( short i, 
                    CmoRequestOptions* RequestOptions );


   short ReturnNullInt( short i, 
                        CmoRequestOptions* RequestOptions );

#if !defined( MOCLIENT_IPHONE ) 
#if !defined( USE_MOBILE_OBJECTS )
   CURRENCY ReturnCurrency( CURRENCY c, 
                            CmoRequestOptions* RequestOptions );


   CURRENCY ReturnNullCurrency( CURRENCY c, 
                                CmoRequestOptions* RequestOptions );


   DATE ReturnDate( DATE d, 
                    CmoRequestOptions* RequestOptions );


   DATE ReturnNullDate( DATE d, 
                        CmoRequestOptions* RequestOptions );
#endif
#endif

   CmoRecordset* ReturnRS( CmoRecordset* rs, 
                           CmoRequestOptions* RequestOptions );


   CmoRecordset* ReturnEmptyRS( CmoRecordset* rs, 
                                CmoRequestOptions* RequestOptions );


   CmoRecordset* ReturnDeletedRS( CmoRecordset* rs, 
                                  CmoRequestOptions* RequestOptions );


   long CompareTestData( CmoRecordset* rs, 
                         long NumRecords, 
                         CmoRequestOptions* RequestOptions );

};


#endif
