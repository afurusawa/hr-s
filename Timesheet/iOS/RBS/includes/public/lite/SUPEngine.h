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

SUPEngine.h

Interface for push, client settings, and engine configuration
*/

#ifndef __SUPENGINE_H__
#define __SUPENGINE_H__

#import <UIKit/UIKit.h>

// Return codes by SUPEngine startEngine, stopEngine and restartEngine APIs
// Operation successful 
#define kSUPEngineSuccess           0

// Operation failed. General failure
#define kSUPEngineFailure           -1

// Operation failed
// Unable to access the key from MessagingVault
// MessagingVault must be unlocked before performing this operation
#define kSUPEngineMessagingKeyNotAvailable   -100


// Used to control back end engine that connects to server and delivers data
@interface SUPEngine : NSObject {
   BOOL keepThreadRunning;
   BOOL waitForStartFlag;
   volatile BOOL isItDeadYet;
   BOOL theDeviceWokeUp;
}

@property (nonatomic, assign) BOOL keepThreadRunning;
@property (nonatomic, assign) BOOL waitForStartFlag;
@property (nonatomic, assign) volatile BOOL isItDeadYet;
@property (nonatomic, assign) BOOL theDeviceWokeUp;

// Determines whether assertions while be displayed or not
+ (void) setAssertionState:(bool)hideAssertions;

// Singleton access.  Call this to get access to object before calling startEngine, stopEngine, or restartEngine
+ (SUPEngine*) getSUPEngine;

// Begin delivering data to and from server
// If unable to access the key from MessagingVault it returns kSUPEngineMessagingKeyNotAvailable
- (NSInteger) BRNFNstartEngine;

// Stop delivering data to and from server.  Call when application is terminating
- (NSInteger) BRNFNstopEngine;

// Version string of library
+ (NSString*) getVersion;

// Determines if messaging DB exists
+ (BOOL) isMessagingDBExist;

// Reset messaging state by deleting messaging database and clearing the connection settings
// Also resets the messaging vault as messaging database does not exists anymore
+ (void) resetMessagingState;

@end

#endif // __SUPENGINE_H__
