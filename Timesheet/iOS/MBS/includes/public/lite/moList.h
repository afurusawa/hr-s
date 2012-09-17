/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moList.h
*    Platform Dependencies  :
*    Description            : Header file for list class.
*
*    Notes                  :
******************************************************************************/

#ifndef CmoList_H_INCLUDED
#define CmoList_H_INCLUDED

#include "moOS.h"
#include "moTypes.h"

#if defined( MOCLIENT_IPHONE ) || defined( USE_MOBILE_OBJECTS )
#include "tchar.h"
#endif

#ifdef _WIN32
   #include "moThreadSafe.h"
#endif

#define CmoListSUCCESS  0
#define CmoListERROR    -1


class CmoListItem;
class CmoListHead;

typedef CmoListItem* PListItem;
typedef CmoListHead* PListHead;
typedef void* PData;


typedef void ( *TOnClearEvent )( void* pData );


// CmoListItem
//***********************************************************
class CmoListItem
{
public:
   CmoListItem();
   ~CmoListItem();

   PData getData();
   void setData( PData Value );

   PListItem getNext();
   void setNext( PListItem Value );

   PListItem getPrev();
   void setPrev( PListItem Value );

private:
   PData FpData;

   PListItem FpNext;

   PListItem FpPrev;
};// CmoListItem
//***********************************************************



// CmoListHead
//***********************************************************
class CmoListHead
{
private:
   PListItem FpFirstItem;
public:
   CmoListHead();
   ~CmoListHead();
   PListItem getFirstItem();
   void setFirstItem( PListItem Value );
};



// CmoList
//***********************************************************
class CmoList
{
public:
   CmoList( TOnClearEvent OnClearEvent );
   ~CmoList();


   I32 Delete();
   I32 Delete( I32 ulPosition );
   I32 Delete( PListItem pItem );

   bool getEOL();
   bool getBOL();

   bool AtEOF(){ return getEOL();}
   bool AtBOF(){ return getBOL();}

   I32 getCount();

   TCHAR* getName();
   void setName( TCHAR* pucName );

   void Insert( I32 lPosition,
                void* pData,
                bool& bSuccess );

   void Add( void* pData );

   void Find( void* pData,
              I32& ulPos );

   PListItem ItemAtPos( I32 lPosition );

   bool GotoItem( void* pData );

   PListItem getCurrent();

   PListItem First();
   PListItem Next();
   PListItem Prior();
   PListItem Last();

   void DoOnClear( void* pData );

   void ClearList();


   void setBookMark( void* pBookMark );
   void* getBookMark();
   void setOnClearEvent( TOnClearEvent m_pfnValue ){ m_pfnOnClear = m_pfnValue;}

   void MoveFirstItem( CmoList *poFromList );

private:
#ifdef _WIN32
   CmoCriticalSection m_CS;
#endif

   bool m_bEOL;
   bool m_bBOL;
   I32 m_lCount;
   TCHAR* FpucName;
   PListHead FpListHead;
   PListItem FpListTail;
   PListItem FpCurrentItem;
   void setCurrent( PListItem pItem );
   void setCount( I32 ulCount );
   void setEOL( bool Value );
   void setBOL( bool Value );
   void InternalInit();

   TOnClearEvent m_pfnOnClear;


protected:
   PListHead getListHead();

   void setListHead( PListHead Value );

   PListItem getListTail();

   void setListTail( PListItem Value );

};// CmoList
//***********************************************************



#endif

