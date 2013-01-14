/*******************************************************************************
* Source File : moThreadSafe.h
* Date Created: 07/28/2000
* Copyright   : 2000 - 2003, Extended Systems, Inc.
* Description : Header file for misc class having to do with thread safe issues.
* Notes       :
*
*******************************************************************************/

#ifndef CDMTHREADSAFE_H_INLCLUDED
#define CDMTHREADSAFE_H_INLCLUDED

#include "moOS.h"

#ifndef ESI_PALM

#if defined( MOCLIENT_IPHONE ) || defined( USE_MOBILE_OBJECTS )
#include <pthread.h>
#endif

// Lockable object base class
class CmoLockableObject
{
public:
   CmoLockableObject(){}
   virtual ~CmoLockableObject(){}
   
private:
   virtual void Enter() = 0;
   virtual void Leave() = 0;

   friend class CmoLock;
};// CmoLockableObject


class CmoCriticalSection: public CmoLockableObject
{
public:
   CmoCriticalSection();
   virtual ~CmoCriticalSection();

private:
#if defined( MOCLIENT_IPHONE ) || defined( USE_MOBILE_OBJECTS )
   pthread_mutex_t   m_mutex;
#else    // Wince & Win32
   CRITICAL_SECTION m_CritSect;
#endif
   
   virtual void Enter();
   virtual void Leave();
   
   friend class CmoLock;
};// CmoCriticalSection


class CmoLock
{
public:
   CmoLock( CmoLockableObject* pObject );
   ~CmoLock();
   void Unlock();
   void Lock();

private:
   CmoLockableObject* m_pObject;
   int mlLockCount;

};// CmoLock

#endif // not ESI_PALM

#endif// CDMTHREADSAFE_H_INLCLUDED






