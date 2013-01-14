//
//  SUPRelationshipMetaData.h
//  clientrt
//
//  Created by Scott Kovatch on 8/23/11.
//  Copyright (c) 2011 Sybase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPAttributeMetaDataRBS.h"

@interface SUPRelationshipMetaData : SUPAttributeMetaDataRBS

@property(readwrite, retain, nonatomic) NSString *type;
@property(readwrite, retain, nonatomic) NSString *cascadeString;
@property(readwrite, retain, nonatomic) NSString *inverseEntity;
@property(readwrite, retain, nonatomic) NSString *inverseAttribute;
@property(readwrite, retain, nonatomic) NSString *fkAttribute;
@property(readwrite, retain, nonatomic) SUPAttributeMetaDataRBS *foreignKey;
@property(readonly, assign, nonatomic) BOOL isMany;
@property(readonly, assign, nonatomic) BOOL isCascade;
@property(readonly, assign, nonatomic) BOOL isCascadeDelete;
@property(readonly, assign, nonatomic) BOOL isCascadeSave;
@property(readonly, assign, nonatomic) BOOL isCascadeCreate;
@property(readonly, assign, nonatomic) BOOL isCascadeUpdate;

@end
