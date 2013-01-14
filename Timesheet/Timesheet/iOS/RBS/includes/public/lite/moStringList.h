/******************************************************************************
*    Copyright 2001 - 2003 Extended Systems
*    Source File            : moStrinList.h
*    Platform Dependencies  :
*    Description            : Header file for string list class.
*
*    Notes                  :
******************************************************************************/
#ifndef CmoStringList_H_INCLUDED
#define CmoStringList_H_INCLUDED


#include "moOS.h"
#include "moString.h"
#include "moTypes.h"
#include "moList.h"
#include "moError.h"



using namespace mo;


/******************************************************************************
*    Name       :  CmoStringList
******************************************************************************/
template <class T>
class CmoStringList
{
public:
   CmoStringList();

   ~CmoStringList();

   T& ItemAtPos( I32 lPos );

   void Add( T& strValue );

   void Add( const TCHAR* pcValue );

   void Delete( I32 lPos );

   I32 IndexOf( const TCHAR* pcValue );

   I32 IndexOf( T& strValue );

   void LoadFromStr( T& strValue,
                     const TCHAR* pcDelim );

   I32 getCount(){ return m_List->getCount();}

   I32 FindValueName( T& strName );

   I32 FindValue( T& strValue );

   T GetValue( I32 lPos );

   //Return the raw string data
   T GetAt( I32 lPos );

   void Clear(){ m_List->ClearList();}

private:

   CmoList* m_List;

   static void OnClear( void* pData );

};// CmoStringList









// CmoStringList
//*****************************************************************************
//*****************************************************************************


/******************************************************************************
*    Name       : CmoStringList
*    Created    : 06/19/2001 mo
*    Desc       :
*    Input      :
*    Output     :
*    Return Val :
*    Notes      :
******************************************************************************/
template <class T>CmoStringList<T>::CmoStringList()
{
   m_List = new CmoList( OnClear );
}



/******************************************************************************
*    Name       : OnClear
*    Created    : 06/19/2001 mo
*    Desc       :
*    Input      :
*    Output     :
*    Return Val :
*    Notes      :
******************************************************************************/
template <class T>
void CmoStringList<T>::OnClear( void* pData )
{
   if ( pData )
      delete ( CmoString* )pData;
}




/******************************************************************************
*    Name       : ~CmoStringList
*    Created    : 06/19/2001 mo
*    Desc       :
*    Input      :
*    Output     :
*    Return Val :
*    Notes      :
******************************************************************************/
template <class T>
CmoStringList<T>::~CmoStringList()
{
   delete m_List;
}






/******************************************************************************
*    Name       : ItemAtPos
*    Created    : 06/19/2001 mo
*    Desc       :
*    Input      :
*    Output     :
*    Return Val :
*    Notes      :
******************************************************************************/
template <class T>
T& CmoStringList<T>::ItemAtPos( I32 lPos )
{

   static T strEmpty;
   if ( lPos < 0 || lPos > getCount() - 1 )
   {
      return strEmpty;
   }


   T* pstrItem;

   PListItem pItem = m_List->ItemAtPos( lPos );

   if ( pItem )
   {
      pstrItem = ( T* )(pItem->getData() );
      return *pstrItem;
   }

   // return empty string
   else
   {
      return strEmpty;
   }

}// ItemAtPos




/******************************************************************************
*    Name       : Add
*    Created    : 06/19/2001 mo
*    Desc       :
*    Input      :
*    Output     :
*    Return Val :
*    Notes      :
******************************************************************************/
template <class T>
void CmoStringList<T>::Add( T& strValue )
{
   // create a version on the heap.
   T* pstrValue = new T( strValue );
   m_List->Add( ( void* )pstrValue );
}// Add


template <class T>
void CmoStringList<T>::Add( const TCHAR* pcValue )
{
   T strValue = pcValue;
   this->Add( strValue );
}


/******************************************************************************
*    Name       : Delete
*    Created    : 06/19/2001 mo
*    Desc       :
*    Input      :
*    Output     :
*    Return Val :  
*    Notes      :
******************************************************************************/
template <class T>
void CmoStringList<T>::Delete( I32 lPos )
{
   m_List->Delete( lPos );
}// Add




/******************************************************************************
*  Name:
*
*  Description:
*
*  Parameters:
*
*  Preconditions:  none
*
*  Postconditions: none
******************************************************************************/
template <class T>
I32 CmoStringList<T>::IndexOf( const TCHAR* pcValue )
{
   T* pstrValue = new T( pcValue );

   PListItem pItem;

   m_List->First();

   for ( I32 lPos = 0; lPos < m_List->getCount(); ++lPos )
   {
      pItem = m_List->getCurrent();
      T* pstrItem = ( T* )( pItem->getData() );

      if ( pstrItem->AsLower() == pstrValue->AsLower() )
      {
         delete pstrValue;
         return lPos;
      }

      m_List->Next();
   }

   delete pstrValue;

   return -1;

}// IndexOf


template <class T>
I32 CmoStringList<T>::IndexOf( T& strValue )
{
   CmoString* pstrValue = new CmoString( strValue );
   I32 lResult = IndexOf( pstrValue->c_str() );

   delete pstrValue;

   return lResult;
}// IndexOf



/******************************************************************************
*  Name:
*
*  Description:
*
*  Parameters:
*
*  Preconditions:  none
*
*  Postconditions: none
******************************************************************************/
template <class T>
I32 CmoStringList<T>::FindValueName( T& strName )
{
   PListItem pItem;
   m_List->First();
   for ( I32 lPos = 0; lPos < m_List->getCount(); ++lPos )
   {
      pItem = m_List->getCurrent();
      T* strItem = ( T* )( pItem->getData() );

      T strDelim = _T("=");

      if ( strItem->StrBeforeToken( strDelim.c_str() ).AsLower().Trim() == strName.AsLower() )
         return lPos;

      m_List->Next();
   }

   return -1;
}// FindValueName




/******************************************************************************
*    Name       : FindValue
*    Created    : 06/05/2001 mo
*    Desc       :
*    Input      :
*    Output     :
*    Return Val :
*    Notes      :
******************************************************************************/
template <class T>
I32 CmoStringList<T>::FindValue( T& strValue )
{
   PListItem pItem;
   m_List->First();
   for ( I32 lPos = 0; lPos < m_List->getCount(); ++lPos )
   {
      pItem = m_List->getCurrent();
      T* strItem = ( T* )( pItem->getData() );

      if ( strItem->StrAfterToken( _T("=") ).AsLower().Trim() == strValue.AsLower() )
         return lPos;

      m_List->Next();
   }

   return -1;
}// FindValue







/******************************************************************************
*    Created    : Dean Mikel 6/5/2001
*    Desc       : Populates string list from a string where items are defined
                  by a delimiter char/string.
*    Return Val :
*    Notes      : A phrase, section where delimiters are ignored, can be defined
                  by wrapping the section in double quotes.
******************************************************************************/
template <class T>
void CmoStringList<T>::LoadFromStr( T& strValue,
                                    const TCHAR* pcDelim )
{
   this->Clear();

   T* pstrTemp = new T();
   T* pstrToken = new T();

   if ( strValue.Length() <= 1 )
      return;

   I32 lEndPos,
      lCurrentPos = 0;


   while ( true )
   {
      // if the pos at end of string then were finished.
      if ( strValue[ lCurrentPos ] == 0 )
         break;


      // Handle dbl quotes
      //***************************************************
      // convert char to whatever type of string is being used for T.
      *pstrToken = _T("\"");

      if ( strValue[ lCurrentPos ] == *pstrToken->c_str() )
      {
         // find the end dbl quote, start just passed the first ".
         lEndPos = strValue.Find( pstrToken->c_str(),
                                  lCurrentPos + 1 );


         // if second dbl quote found, treat as phrase (ignoring delimiter chars)
         if ( lEndPos > 0 )
         {
            // move past " and only copy up to ending "
            *pstrTemp = strValue.SubStr( lCurrentPos + 1, lEndPos - lCurrentPos - 1 );

            Add( *pstrTemp );

            //update current position before searching for next item in list.
            // move past end "
            lCurrentPos = lEndPos + 2;

            // process next phrase or delimiter.
            continue;
         }
      }
      //***************************************************



      // No dbl quoted phrase, so look for next delimiter
      //***************************************************
      *pstrToken = pcDelim;

      // look for delim char
      lEndPos = strValue.Find( pstrToken->c_str(),
                               lCurrentPos );
      if ( lEndPos >= 0 )
      {
         *pstrTemp = strValue.SubStr( lCurrentPos, lEndPos - lCurrentPos );

         Add( *pstrTemp );

         //update current position before searching for next item in list.
         lCurrentPos = lEndPos + pstrToken->Length();
      }// if


      // add last item
      else if ( strValue[ lCurrentPos ] != 0 )
      {
         *pstrTemp = strValue.SubStr( lCurrentPos, strValue.Length() - lCurrentPos );

         Add( *pstrTemp );

         break;
      }// else if

      else
         break;
      //***************************************************

   }// while

   // cleanup.
   if ( pstrToken )
      delete pstrToken;

   if ( pstrTemp )
      delete pstrTemp;

}// LoadFromStr



template <class T>
T CmoStringList<T>::GetValue( I32 lPos )
{
   T strResult;

   strResult = ItemAtPos( lPos );

   T strDelim = _T("=");

   return strResult.StrAfterToken( strDelim.c_str() ).Trim();
}

template <class T>
T CmoStringList<T>::GetAt( I32 lPos )
{
   T strResult;

   strResult = ItemAtPos( lPos );

   return strResult;
}


#endif //CmoStringList_H_INCLUDED


