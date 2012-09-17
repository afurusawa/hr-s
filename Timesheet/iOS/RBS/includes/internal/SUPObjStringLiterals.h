/*
 *  SUPObjStringLiterals.h
 *  SUPObj
 *
 *  Created by Douglas Lowder on 2/8/10.
 *  Copyright 2010 Sybase. All rights reserved.
 *
 */

// Error message defines
#define SUPOBJ_NULLMETHODMESSAGE "SUPDeliverMessage: null method, no message to deliver"
#define SUPOBJ_NOQUEUECONNECTIONFOUND "No queue connection found"
#define SUPOBJ_GOTSUPINITIALIZE "SUPObj Got SUPInitialize()"
#define SUPOBJ_GOTSUPCALLDISPOSE "SUPObj Got SUPDispose()"
#define SUPOBJ_GOTSUPASYNCMETHODCALLFORSERVER "SUPObj Got SUPAsyncMethodCallFromServer(): %s"
#define SUPOBJ_GOTSUPPIMCHANGENOTIFICATION "SUPObj Got SUPPIMChangeNotification()"
#define SUPOBJ_GOTSUPREFRESHALLDATA "SUPObj Got SUPRefreshAllData()"
#define SUPOBJ_GOTSUPDATASTORECLEARED "SUPObj Got SUPDatastoreCleared()"
#define SUPOBJ_GOTSUPCONNECTIONSTATECHANGED "SUPObj Got SUPConnectionStateChanged()"
#define SUPOBJ_INVALIDJSONHEADER "Header received from server is not a valid JsonObject."
#define SUPOBJ_CIDCANNOTBEZERO "cid should not be 0 in the message header from server."
#define SUPOBJ_CIDISMISSING "No cid in the message headers from server."
#define SUPOBJ_CLIENTCIDISINVALID "SUPObj: cid value sent by application is invalid"
#define SUPOBJ_INVALIDCLIENTMESSAGEFORMAT "The format of request from SUP application is incorrect"
#define SUPOBJ_INVALIDCONNECTIONSTATE "SUPObj: connection state received is not a valid value: %d"
#define SUPOBJ_INVALIDCONNECTIONTYPE "SUPObj: connection type received is not a valid value: %d"







