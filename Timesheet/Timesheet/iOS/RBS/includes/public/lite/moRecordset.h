/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moRecordset.h
*    Platform Dependencies  :
*    Description            : Declaration file for CmoRecordset class.
*
*    Notes                  : CmoRecordset is a cross platform interface with
*                             methods similar to ADO recordset.
******************************************************************************/


#ifndef CmoRecordset_H_INCLUDED
#define CmoRecordset_H_INCLUDED



#include "moTypes.h"
#include "moString.h"
#include "moBinary.h"
#include "moDateTime.h"
#include "moStringList.h"
#include "moDBCommon.h"


class ECFieldInfo;
class ECIndexInfo;
class ECDbSchema;
class ECDbIndexes;
class ECDatabase;
class ECField;


namespace mo
{

   class CmoField;
   class CmoFields;
   class CmoIndex;
   class CmoIndexes;
   class CmoParam;

   typedef enum
   {
      ssStart,
      ssStartData,
      ssContinueData,
      ssFinished
   } STREAM_STATE;


   /******************************************************************************
   ******************************************************************************/
   class CmoRecordset
   {
   public:
      CmoRecordset();
      ~CmoRecordset();

      void AddNew();
      void AppendFrom( CmoRecordset* pSourceRS,
                       MOAppendFromOption eOption );
      void CancelUpdate();
      void Close();
      void CopyTable( MOCopyOption eCopyOption,
                      CmoRecordset* pResultRS,
                      const TCHAR* pcTableName = NULL );
      CmoField* CreateField( const TCHAR* pcFieldName,
                            MOFieldType eFieldType,
                            UI32 ulFieldSize = 0 );
      void CreateIndex( const TCHAR* pcIndexName,
                        const TCHAR* pcIndexExpr );
      void CreateTable( const TCHAR* pcTableName,
                        UI32 ulCreatorID = 0 );
      void CreateTable();
      void DeleteTable( const TCHAR* pcTableName );
      void Delete();
      void Edit();
      void EmptyTable();
      CmoField* FieldByName( const TCHAR* pcFieldName );
      CmoField* Field( UI32 ulPos );
      UI32 FieldCount();
      void GetBinary( const TCHAR* pcFieldName,
                      CmoBinary* pResult );
      bool GetBOF();
      bool GetBoolean( const TCHAR* pcFieldName );
      I64 GetCurrency( const TCHAR* pcFieldName );
      void GetDateTime( const TCHAR* pcFieldName,
                        CmoDateTime* pResult );
      R64 GetDouble( const TCHAR* pcFieldName );
      bool GetEOF();
      I32 GetLong( const TCHAR* pcFieldName );
      I16 GetShort( const TCHAR* pcFieldName );
      R32 GetSingle( const TCHAR* pcFieldName );
      void GetString( const TCHAR* pcFieldName,
                      CmoString* pstrResult );
      void GetString( const TCHAR* pcFieldName,
                      TCHAR **ppcResult );
      CmoString GetString( const TCHAR* pcFieldName );
      UI32 GetULong( const TCHAR* pcFieldName );
      UI16 GetUShort( const TCHAR* pcFieldName );
      bool IsFieldEmpty( const TCHAR* pcFieldName );
      void SetEmpty( const TCHAR* pcFieldName );
      bool LocateBoolean( const TCHAR* pcFieldName,
                          bool bFieldValue,
                          bool bContinue = false );
      bool LocateDateTime( const TCHAR* pcFieldName,
                           CmoDateTime* pFieldValue,
                           bool bContinue = false );
      bool LocateDouble( const TCHAR* pcFieldName,
                         const R64& dFieldValue,
                         bool bContinue = false );
      bool LocateLong( const TCHAR* pcFieldName,
                       I32 lFieldValue,
                       bool bContinue = false );
      bool LocateShort( const TCHAR* pcFieldName,
                        I16 sFieldValue,
                        bool bContinue = false );
      bool LocateString( const TCHAR *pcFieldName,
                         const TCHAR *pcFieldValue,
                         bool bCaseInsensitive = true,
                         bool bContinue = false );
      void MoveFirst();
      void MoveLast();
      void MoveNext();
      void MovePrevious();
      void Open( const TCHAR* pcTableName);
      void Open();
      UI32 RecordCount(){ return mlRecordCount;}
      void SaveAs( const TCHAR* pcTableName,
                   MOSaveAsOption eOption = soDeleteIfExists,
                   UI32 ulCreatorID = 0 );
      void SetString( const TCHAR *pcFieldName,
                      const TCHAR *pcData );
      void SetString( const TCHAR *pcFieldName,
                      CmoString* pstrData );
      void SetBinary( const TCHAR* pcFieldName,
                      const void* pData,
                      UI32 ulDataSize,
                      bool bIsNullFlags = false
                    );
      void SetShort( const TCHAR* pcFieldName,
                     I16 sData );
      void SetUShort( const TCHAR* pcFieldName,
                      UI16 usData );
      void SetLong( const TCHAR* pcFieldName,
                    I32 lData );
      void SetULong( const TCHAR* pcFieldName,
                     UI32 ulData );
      void SetDouble( const TCHAR* pcFieldName,
                      R64 dData );
      void SetDateTime( const TCHAR* pcFieldName,
                        CmoDateTime* pData );
      void SetCurrency( const TCHAR* pcFieldName,
                        const I64& cyData );
      void SetSingle( const TCHAR* pcFieldName,
                      R32 fData );
      void SetBoolean( const TCHAR* pcFieldName,
                       bool bData );
      bool TableExists( const TCHAR* pcTableName );
      void Update();
      void SetIndex( const TCHAR* pcIndexName );
      const TCHAR *GetIndex();
      bool Active(){ return GetActive();}
      bool GetActive(){ return meState != dsInactive;};
      void* GetBookMark();
      void SetBookMark( void* pvBookMark );
      void SetCursorLocation( MOCursorLocation eLocation );
      MOCursorLocation GetCursorLocation();
      MOState GetState(){ return meState;};
      CmoString& GetTableName(){ return mstrTableName;}
      void SetTableName( const TCHAR* pcTableName );
      MOTableLifetime GetTableLifetime();
      void SetTableLifetime( MOTableLifetime eLife );
      void FullPathTableName( const TCHAR*   pcTableName,
                              CmoString   *poTableName );
     
   protected:
#if defined( SYSTEM_TEST )
   public:
#endif
      ECDatabase     *mpoEDB;
      ECDatabase     *mpoSchemaEDB;
      ECField        *mpoField;
      ECDbSchema     *mpoSchema;
      ECDbIndexes    *mpoSchemaIndexes;
      CmoFields      *mpoFields;
      CmoIndexes     *mpoIndexes;
      bool           mbTempTable;
      CmoString      mstrReceivedTableName;
      CmoString      mstrTableName;
      CmoString      mstrIndexName;
      CmoString      mstrDefaultPath;
      MOState        meState;
      TCHAR          *mpcStringBuffer;
      bool           mbEOF;
      bool           mbBOF;
      CmoBinary      moNullFlags;
      static UI32    mulUniqueTableName;
      I32            mlRecordCount;

      void Delete( bool bDecrementRecordCounter );

      I32 Locate( const TCHAR* pcFieldName,
                  ECField *poSearchVal,
                  bool bCaseInsensitive,
                  bool bContinue,
                  bool *pbFound );
      I32 FindIndex( const TCHAR *pcFieldName,
                     const TCHAR **ppcIndexName );
      void FixSignedFieldValue();
      void CountRecords();
      void GetMaxChangeCounter();
      void HandleEDBError( I32 lError,
                           const TCHAR* pcFileName,
                           I32 lLineNo,
                           I32 lMOErrorCode,
                           TCHAR *pcDetail );
      void ProcessSchemaFile();
      void UpdateSchemaFile();
      void WriteToStream( void *pvStream,
                          STREAM_STATE *peState );
      void ReadFromStream( void *pvStream );
      I32 ReadFieldsFromStream( void  *pvStream );
      void LoadFromBuffer( UI8* pucData,
                           UI32 ulDataSize,
                           bool bChangeByteOrder );
      void SaveToBuffer( bool bChangeByteOrder,
                         UI8* pucBuffer,
                         UI32* pulBufferSize,
                         UI32* pulMaxRecords,
                         CmoStringList<CmoString>* pExcludeList );
      I32 GetNullFlagBufSize( UI32 ulNumExtraFields = 0 );
      I32 CommitNulls();
      I32 SetNullFlag( I32 lFieldNum,
                       I32 lNullFlag );
      I32 IsNull( const TCHAR *pcFieldName,
                  bool *pbNull );
      I32 GetNullFlags( I8 **pcNULLFlags );
      I32 RecordMovement();
      void SetDefaultPath();
      void GetTempFile( CmoString *poTemp );
      void SetDefaultPathToTemp();
      I32 SetFieldValue( const TCHAR *pcFieldName,
                         ECField     *poFieldValue,
                         bool        bIsNullFlags = false );
      I32 GetFieldValue( const TCHAR *pcFieldName );
      void CopyRecords( CmoRecordset* poDestination,
                        MOAppendFromOption eOption );
      void SetLastErr( I32 lErrorCode,
                       const TCHAR* pcFileName,
                       I32 lLineNo,
                       const TCHAR* pcDetail = NULL,
                       I32 lNativeErrorCode = 0 );

      friend class CmoFields;
      friend class CmoField;
      friend class CmoParam;
      friend class ClqdConfig;
   };



   /******************************************************************************
   ******************************************************************************/
   class CmoField
   {
   public:
      CmoField();
      CmoField( CmoField& Field );
      ~CmoField();

      void Clear();
      I32 GetActualSize();
      I32 GetDefinedSize(){ return mlDefinedSize;}
      MOFieldType GetFieldType(){ return meFieldType;}
      CmoString& GetName(){ return *mpstrFieldName;}
      bool GetNULL();
      UI32 GetPos(){ return mulPos;};
      void SetPos( UI32 ulPos ){ mulPos = ulPos;};
      CmoRecordset* GetOwner(){ return mpoOwner;}
      void SetName( const TCHAR* pcValue ){ *mpstrFieldName = pcValue;}

   private:
      void SetDefinedSize( I32 lValue ){ mlDefinedSize = lValue;};
      void SetFieldType( MOFieldType eValue ){ meFieldType = eValue;}
      void SetActualSize( I32 lValue ){ mlActualSize = lValue;}
      bool GetHidden();
      bool GetModified();
      void Init();
      void SetOwner( CmoRecordset* pValue ){ mpoOwner = pValue;}

      CmoRecordset   *mpoOwner;
      I32            mlActualSize;
      I32            mlDefinedSize;
      MOFieldType    meFieldType;
      CmoString      *mpstrFieldName;
      UI32           mulPos;

      friend class CmoRecordset;
      friend class CmoFields;
      friend class MOField;
   }; // CmoField



   /******************************************************************************
   ******************************************************************************/
   class CmoFields
   {
   public:
      CmoFields( CmoRecordset* pOwner );
      ~CmoFields();
      CmoField* Add( const TCHAR* pcFieldName );
      void Clear();
      CmoField* Field( UI32 ulPos );
      CmoField* FieldByName( const TCHAR* pcFieldName );
      I32 FieldCount();

   private:
      CmoRecordset* mpoOwner;

      void *mpoFldArray;
      void *mpoFldMap;
      void *mpoCS;
   }; // CmoFields




   /******************************************************************************
   ******************************************************************************/
   class CmoIndexes
   {
   public:
      CmoIndexes();
      ~CmoIndexes();
      CmoIndex* Add();
      void Clear();
      CmoIndex* Index( UI32 ulPos );
      CmoIndex* IndexByName( const TCHAR* pcIndexName );
      I32 IndexCount(){ return mpoList->getCount();}

   private:
      CmoList* mpoList;
   }; // Cmoindexes


   /******************************************************************************
   ******************************************************************************/
   class CmoIndex
   {
   public:
      CmoIndex(){};
      ~CmoIndex(){};
      CmoString& GetName(){ return mstrIndexName;}
      CmoString& GetExpr(){ return mstrIndexExpr;}
      void SetName( const TCHAR* pcValue ){ mstrIndexName = pcValue;}
      void SetExpr( const TCHAR* pcValue ){ mstrIndexExpr = pcValue;}

   private:
      CmoString mstrIndexName;
      CmoString mstrIndexExpr;
   }; // CmoIndex

}// namespace mo


#endif // CmoRecordset_H_INCLUDED

