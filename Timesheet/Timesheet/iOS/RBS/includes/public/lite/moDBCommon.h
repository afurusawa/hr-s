/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moDBCommon.h
*    Platform Dependencies  :
*    Description            : Header file db definitions.
*    Notes                  :
******************************************************************************/

#ifndef mo_db_common_H_INCLUDED
#define mo_db_common_H_INCLUDED


#ifdef ESI_PALM
   #define MO_CREATOR_ID       'mo'
#endif

// This enum cannot exceed 256 items.
// The tranport casts the item to a UI8.
typedef enum MOFieldType
{
   ftAutoInc=0,
   ftCurrency=1,
   ftString=2,
   ftBinary=3,
   ftLong=4,
   ftULong=5,
   ftShort=6,
   ftUShort=7,
   ftSingle=8,
   ftDouble=9,
   ftDateTime=10,
   ftBoolean=11,
   ftDecimal=12, //dtDecimal is only used for .net client, 
			  //C++ clients shall never use this type in their apps
   
   ftUnknown=13,
   ftBytes=14,
   ftByte=15,
   ftSByte=16,
   ftInt64=17,
   ftUInt64=18,
   ftGuid =19
}MOFieldType;


typedef enum  MOAppendFromOption
{
   afAll,
   afCurrentRecordOnly

}MOAppendFromOption;


typedef enum MOSaveAsOption
{
   soAppendIfExists,
   soDeleteIfExists
}MOSaveAsOption;

typedef enum MOCursorLocation
{
   clUseLocalStore,
   clUseInMemory
}MOCursorLocation;

typedef enum MOTableLifetime
{
   rlPermanent,
   rlTemporary
} MOTableLifetime;

typedef enum MOState
{
   dsInactive,
   dsBrowse,
   dsEdit,
   dsAppend
}MOState;

typedef enum MOCopyOption
{
   coStructureOnly,
   coStructureAndData
} MOCopyOption;

#endif // mo_db_common_H_INCLUDED
